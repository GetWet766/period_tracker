import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:period_tracker/features/profile/data/models/profile_details_model.dart';
import 'package:period_tracker/features/profile/data/models/profile_model.dart';
import 'package:period_tracker/features/quiz/data/datasources/local_quiz_datasource.dart';
import 'package:period_tracker/features/quiz/data/datasources/remote_quiz_datasource.dart';
import 'package:period_tracker/features/quiz/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  QuizRepositoryImpl({
    required LocalQuizDataSource localDataSource,
    required RemoteQuizDataSource remoteDataSource,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource;

  final LocalQuizDataSource _localDataSource;
  final RemoteQuizDataSource _remoteDataSource;

  @override
  Map<String, dynamic> getQuizAnswers() {
    return _localDataSource.getQuizAnswers();
  }

  @override
  Future<Either<Failure, void>> saveQuizAnswer(
    String questionId,
    dynamic answer,
  ) async {
    try {
      await _localDataSource.saveQuizAnswer(questionId, answer);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeQuiz() async {
    try {
      // Mark quiz as completed locally
      await _localDataSource.setQuizCompleted(value: true);

      final quizAnswers = _localDataSource.getQuizAnswers();

      // Try to sync quiz data to remote profile
      try {
        await _remoteDataSource.syncQuizDataToProfile(quizAnswers);
      } on Exception {
        // If sync fails (guest mode or offline), create local profile
        await _createLocalProfileFromQuiz(quizAnswers);
      }

      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<void> _createLocalProfileFromQuiz(
    Map<String, dynamic> quizAnswers,
  ) async {
    try {
      final profileLocalDataSource = sl<ProfileLocalDataSource>();

      // Parse dates from quiz answers
      DateTime? birthDate;
      if (quizAnswers['birth_date'] != null) {
        birthDate = DateTime.parse(quizAnswers['birth_date'] as String);
      }

      DateTime? lastPeriod;
      if (quizAnswers['last_period'] != null) {
        lastPeriod = DateTime.parse(quizAnswers['last_period'] as String);
      }

      // Create profile details from quiz answers with defaults
      final profileDetails = ProfileDetailsModel(
        id: 'guest_details',
        birthDate:
            birthDate ??
            DateTime.now().subtract(const Duration(days: 365 * 25)),
        weight: quizAnswers['weight'] as int? ?? 60,
        height: quizAnswers['height'] as int? ?? 165,
        periodAvgLength: quizAnswers['period_avg_length'] as int? ?? 5,
        cycleAvgLength: quizAnswers['cycle_avg_length'] as int? ?? 28,
        lastPeriodDateStart:
            lastPeriod ?? DateTime.now().subtract(const Duration(days: 14)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Create or update local profile
      final existingProfile = profileLocalDataSource.getProfile();
      final profile = ProfileModel(
        id: existingProfile?.id ?? 'guest',
        role: ProfileRole.user,
        displayName: quizAnswers['name'] as String? ?? 'Гость',
        avatarUrl: existingProfile?.avatarUrl,
        createdAt: existingProfile?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        details: profileDetails,
      );

      await profileLocalDataSource.saveProfile(profile);
    } on Exception {
      // Silently fail - quiz is still marked as completed
    }
  }

  @override
  bool isQuizCompleted() {
    return _localDataSource.isQuizCompleted();
  }
}
