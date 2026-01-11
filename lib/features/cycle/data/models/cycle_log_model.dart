import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';

part 'cycle_log_model.freezed.dart';
part 'cycle_log_model.g.dart';

@freezed
abstract class CycleLogModel with _$CycleLogModel {
  const factory CycleLogModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required DateTime date,
    @JsonKey(name: 'flow_level') String? flowLevel,
    List<String>? symptoms,
    String? notes,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _CycleLogModel;

  const CycleLogModel._();

  factory CycleLogModel.fromJson(Map<String, dynamic> json) =>
      _$CycleLogModelFromJson(json);

  CycleLogEntity toEntity() {
    return CycleLogEntity(
      id: id,
      userId: userId,
      date: date,
      flowLevel: FlowLevel.fromString(flowLevel),
      symptoms: symptoms ?? [],
      notes: notes,
      createdAt: createdAt,
    );
  }
}
