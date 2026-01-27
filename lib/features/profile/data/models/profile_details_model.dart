import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_details_entity.dart';

part 'profile_details_model.freezed.dart';
part 'profile_details_model.g.dart';

@freezed
abstract class ProfileDetailsModel with _$ProfileDetailsModel {
  const factory ProfileDetailsModel({
    required String id,
    @JsonKey(name: 'birth_date') required DateTime birthDate,
    required int weight,
    required int height,
    @JsonKey(name: 'cycle_avg_length') required int cycleAvgLength,
    @JsonKey(name: 'period_avg_length') required int periodAvgLength,
    @JsonKey(name: 'last_period_date_start')
    required DateTime lastPeriodDateStart,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'last_period_date_end') DateTime? lastPeriodDateEnd,
  }) = _ProfileDetailsModel;

  const ProfileDetailsModel._();

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsModelFromJson(json);

  ProfileDetailsEntity toEntity() {
    return ProfileDetailsEntity(
      id: id,
      birthDate: birthDate,
      weight: weight,
      height: height,
      cycleAvgLength: cycleAvgLength,
      periodAvgLength: periodAvgLength,
      lastPeriodDateStart: lastPeriodDateStart,
      lastPeriodDateEnd: lastPeriodDateEnd,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
