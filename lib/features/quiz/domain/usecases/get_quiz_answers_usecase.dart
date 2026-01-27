import 'package:period_tracker/features/quiz/domain/repositories/quiz_repository.dart';

class GetQuizAnswersUseCase {
  GetQuizAnswersUseCase(this._repository);

  final QuizRepository _repository;

  Map<String, dynamic> call() {
    return _repository.getQuizAnswers();
  }
}
