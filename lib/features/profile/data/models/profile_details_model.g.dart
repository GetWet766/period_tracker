// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileDetailsModel _$ProfileDetailsModelFromJson(Map<String, dynamic> json) =>
    _ProfileDetailsModel(
      id: json['id'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      weight: (json['weight'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      cycleAvgLength: (json['cycle_avg_length'] as num).toInt(),
      periodAvgLength: (json['period_avg_length'] as num).toInt(),
      lastPeriodDateStart: DateTime.parse(
        json['last_period_date_start'] as String,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      lastPeriodDateEnd: json['last_period_date_end'] == null
          ? null
          : DateTime.parse(json['last_period_date_end'] as String),
    );

Map<String, dynamic> _$ProfileDetailsModelToJson(
  _ProfileDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'birth_date': instance.birthDate.toIso8601String(),
  'weight': instance.weight,
  'height': instance.height,
  'cycle_avg_length': instance.cycleAvgLength,
  'period_avg_length': instance.periodAvgLength,
  'last_period_date_start': instance.lastPeriodDateStart.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'last_period_date_end': instance.lastPeriodDateEnd?.toIso8601String(),
};
