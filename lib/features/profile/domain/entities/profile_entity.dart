import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.id,
    required this.displayName,
    required this.cycleAvgLength,
    required this.periodAvgLength,
    required this.createdAt,
    required this.updatedAt,
    this.birthday,
    this.avatarUrl,
  });

  final String id;
  final String displayName;
  final String? avatarUrl;
  final int cycleAvgLength;
  final int periodAvgLength;
  final DateTime? birthday;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    id,
    displayName,
    avatarUrl,
    cycleAvgLength,
    periodAvgLength,
    createdAt,
    updatedAt,
  ];
}
