import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:period_tracker/features/profile/data/models/profile_details_model.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

enum ProfileRole { user, partner }

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required ProfileRole role,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'profile_details') ProfileDetailsModel? details,
  }) = _ProfileModel;

  const ProfileModel._();

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      role: role,
      displayName: displayName ?? 'Пользователь',
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      details: details?.toEntity(),
    );
  }
}
