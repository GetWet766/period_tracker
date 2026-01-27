import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/common/usecase/usecase.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/quiz/domain/repositories/quiz_repository.dart';

class SaveQuizAnswerParams {
  SaveQuizAnswerParams({required this.questionId, required this.answer});

  final String questionId;
  final dynamic answer;
}

class SaveQuizAnswerUseCase
    implements UseCaseWithParams<void, SaveQuizAnswerParams> {
  SaveQuizAnswerUseCase(this._repository);

  final QuizRepository _repository;

  @override
  Future<Either<Failure, void>> call(SaveQuizAnswerParams params) async {
    return _repository.saveQuizAnswer(params.questionId, params.answer);
  }
}
