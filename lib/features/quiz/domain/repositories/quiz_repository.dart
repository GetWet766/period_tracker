import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';

abstract class QuizRepository {
  Map<String, dynamic> getQuizAnswers();
  Future<Either<Failure, void>> saveQuizAnswer(
    String questionId,
    dynamic answer,
  );
  Future<Either<Failure, void>> completeQuiz();
  bool isQuizCompleted();
}
