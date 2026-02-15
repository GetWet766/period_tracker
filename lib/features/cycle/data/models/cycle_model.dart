import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar_plus/isar_plus.dart';
import 'package:periodility/core/utils/fast_hash_extension.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';

part 'cycle_model.freezed.dart';
part 'cycle_model.g.dart';

@freezed
@JsonSerializable()
@Collection()
class CycleModel with _$CycleModel {
  const CycleModel({
    required this.id,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'user_id') this.userId,
    @JsonKey(name: 'end_date') this.endDate,
    @JsonKey(name: 'created_at') this.createdAt,
    this.isManuallyStarted = false,
  });

  factory CycleModel.fromJson(Map<String, Object?> json) =>
      _$CycleModelFromJson(json);

  Map<String, Object?> toJson() => _$CycleModelToJson(this);

  @override
  final String id;
  @override
  final String? userId;
  @override
  @Index()
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? createdAt;
  @override
  final bool isManuallyStarted;

  @Id()
  int get isarId => id.fastHash();

  CycleEntity toEntity() => CycleEntity(
    id: id,
    userId: userId,
    startDate: startDate,
    endDate: endDate,
    isManuallyStarted: isManuallyStarted,
  );
}
