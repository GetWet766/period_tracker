// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CycleLogModel _$CycleLogModelFromJson(Map<String, dynamic> json) =>
    _CycleLogModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      date: DateTime.parse(json['date'] as String),
      flowLevel: json['flow_level'] as String?,
      symptoms: (json['symptoms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CycleLogModelToJson(_CycleLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date.toIso8601String(),
      'flow_level': instance.flowLevel,
      'symptoms': instance.symptoms,
      'notes': instance.notes,
      'created_at': instance.createdAt.toIso8601String(),
    };
