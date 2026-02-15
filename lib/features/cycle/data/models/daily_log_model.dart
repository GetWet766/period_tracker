import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar_plus/isar_plus.dart';
import 'package:periodility/core/utils/fast_hash_extension.dart';
import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';

import 'package:periodility/features/cycle/domain/entities/flow_level.dart';

part 'daily_log_model.freezed.dart';
part 'daily_log_model.g.dart';

@freezed
@JsonSerializable()
@Collection()
class DailyLogModel with _$DailyLogModel {
  const DailyLogModel({
    required this.id,
    required this.date,
    @JsonKey(name: 'user_id') this.userId,
    this.symptoms,
    this.mood,
    this.notes,
    @JsonKey(name: 'flow_level') this.flowLevel,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory DailyLogModel.fromJson(Map<String, Object?> json) =>
      _$DailyLogModelFromJson(json);

  Map<String, Object?> toJson() => _$DailyLogModelToJson(this);

  @override
  final String id;
  @override
  final String? userId;
  @override
  final DateTime date;
  @override
  final List<String>? symptoms;
  @override
  final String? mood;
  @override
  final String? notes;
  @override
  final FlowLevel? flowLevel;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @Id()
  int get isarId => id.fastHash();

  DailyLogEntity toEntity() => DailyLogEntity(
    id: id,
    userId: userId,
    date: date,
    symptoms: symptoms,
    mood: mood,
    notes: notes,
    flowLevel: flowLevel,
  );
}
