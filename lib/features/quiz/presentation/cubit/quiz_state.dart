part of 'quiz_cubit.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;
  const factory QuizState.loaded({
    required Map<String, dynamic> answers,
  }) = _Loaded;
  const factory QuizState.completed() = _Completed;
  const factory QuizState.error({required String message}) = _Error;
}
