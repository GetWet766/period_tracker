import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    @JsonKey(name: 'cycle_avg_length') required int cycleAvgLength,
    @JsonKey(name: 'period_avg_length') required int periodAvgLength,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'display_name') String? displayName,
    DateTime? birthday,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _ProfileModel;

  const ProfileModel._();

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      displayName: displayName ?? 'Пользователь',
      avatarUrl: avatarUrl,
      birthday: birthday,
      cycleAvgLength: cycleAvgLength,
      periodAvgLength: periodAvgLength,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
