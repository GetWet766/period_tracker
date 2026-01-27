import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:period_tracker/features/quiz/domain/usecases/complete_quiz_usecase.dart';
import 'package:period_tracker/features/quiz/domain/usecases/get_quiz_answers_usecase.dart';
import 'package:period_tracker/features/quiz/domain/usecases/save_quiz_answer_usecase.dart';

part 'quiz_state.dart';
part 'quiz_cubit.freezed.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit({
    required GetQuizAnswersUseCase getQuizAnswersUseCase,
    required SaveQuizAnswerUseCase saveQuizAnswerUseCase,
    required CompleteQuizUseCase completeQuizUseCase,
  }) : _getQuizAnswersUseCase = getQuizAnswersUseCase,
       _saveQuizAnswerUseCase = saveQuizAnswerUseCase,
       _completeQuizUseCase = completeQuizUseCase,
       super(const QuizState.initial());

  final GetQuizAnswersUseCase _getQuizAnswersUseCase;
  final SaveQuizAnswerUseCase _saveQuizAnswerUseCase;
  final CompleteQuizUseCase _completeQuizUseCase;

  void loadAnswers() {
    try {
      final answers = _getQuizAnswersUseCase();
      emit(QuizState.loaded(answers: answers));
    } on Exception catch (e) {
      emit(QuizState.error(message: e.toString()));
    }
  }

  Future<void> saveAnswer(String questionId, dynamic answer) async {
    final result = await _saveQuizAnswerUseCase(
      SaveQuizAnswerParams(questionId: questionId, answer: answer),
    );

    result.fold(
      (failure) => emit(QuizState.error(message: failure.message)),
      (_) => loadAnswers(),
    );
  }

  Future<void> completeQuiz() async {
    final result = await _completeQuizUseCase();

    result.fold(
      (failure) => emit(QuizState.error(message: failure.message)),
      (_) => emit(const QuizState.completed()),
    );
  }
}
