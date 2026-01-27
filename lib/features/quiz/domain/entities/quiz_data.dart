import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_data.freezed.dart';

@freezed
abstract class QuizData with _$QuizData {
  const factory QuizData({
    required List<CycleGoal> goals,
    required int averageCycleLength,
    required bool hasMedicalConditions,
    @Default(false) bool isCompleted,
  }) = _QuizData;
}

enum CycleGoal { pregnancyPlanning, symptomTracking, contraception }
