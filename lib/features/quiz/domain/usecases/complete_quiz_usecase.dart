import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/common/usecase/usecase.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/quiz/domain/repositories/quiz_repository.dart';

class CompleteQuizUseCase implements UseCaseWithoutParams<void> {
  CompleteQuizUseCase(this._repository);

  final QuizRepository _repository;

  @override
  Future<Either<Failure, void>> call() async {
    return _repository.completeQuiz();
  }
}
