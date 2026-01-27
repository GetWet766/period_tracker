import 'package:equatable/equatable.dart';
import 'package:period_tracker/features/profile/data/models/profile_model.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_details_entity.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.id,
    required this.role,
    required this.displayName,
    required this.createdAt,
    required this.updatedAt,
    this.avatarUrl,
    this.details,
  });

  final String id;
  final ProfileRole role;
  final String displayName;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProfileDetailsEntity? details;

  @override
  List<Object?> get props => [
    id,
    role,
    displayName,
    avatarUrl,
    createdAt,
    updatedAt,
    details,
  ];
}
