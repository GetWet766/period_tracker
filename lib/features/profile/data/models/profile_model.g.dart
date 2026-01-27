// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: json['id'] as String,
      role: $enumDecode(_$ProfileRoleEnumMap, json['role']),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      details: json['profile_details'] == null
          ? null
          : ProfileDetailsModel.fromJson(
              json['profile_details'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$ProfileRoleEnumMap[instance.role]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'display_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'profile_details': instance.details,
    };

const _$ProfileRoleEnumMap = {
  ProfileRole.user: 'user',
  ProfileRole.partner: 'partner',
};
