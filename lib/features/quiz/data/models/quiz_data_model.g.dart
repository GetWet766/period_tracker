// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizDataModel _$QuizDataModelFromJson(Map<String, dynamic> json) =>
    _QuizDataModel(
      displayName: json['display_name'] as String,
      birthDate: json['birth_date'] as String,
      weight: (json['weight'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      periodAvgLength: (json['period_avg_length'] as num).toInt(),
      cycleAvgLength: (json['cycle_avg_length'] as num).toInt(),
      lastPeriod: json['last_period'] as bool,
      isCompleted: json['is_completed'] as bool,
    );

Map<String, dynamic> _$QuizDataModelToJson(_QuizDataModel instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'birth_date': instance.birthDate,
      'weight': instance.weight,
      'height': instance.height,
      'period_avg_length': instance.periodAvgLength,
      'cycle_avg_length': instance.cycleAvgLength,
      'last_period': instance.lastPeriod,
      'is_completed': instance.isCompleted,
    };
