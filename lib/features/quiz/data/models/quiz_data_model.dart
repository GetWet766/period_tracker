import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'quiz_data_model.freezed.dart';
part 'quiz_data_model.g.dart';

@HiveType(typeId: 2)
@freezed
abstract class QuizDataModel extends HiveObject with _$QuizDataModel {
  const factory QuizDataModel({
    @HiveField(0) @JsonKey(name: 'display_name') required String displayName,
    @HiveField(1) @JsonKey(name: 'birth_date') required String birthDate,
    @HiveField(2) required int weight,
    @HiveField(3) required int height,
    @HiveField(4)
    @JsonKey(name: 'period_avg_length')
    required int periodAvgLength,
    @HiveField(5)
    @JsonKey(name: 'cycle_avg_length')
    required int cycleAvgLength,
    @HiveField(6) @JsonKey(name: 'last_period') required bool lastPeriod,
    @HiveField(7) @JsonKey(name: 'is_completed') required bool isCompleted,
  }) = _QuizDataModel;

  QuizDataModel._();

  factory QuizDataModel.fromJson(Map<String, dynamic> json) =>
      _$QuizDataModelFromJson(json);
}
