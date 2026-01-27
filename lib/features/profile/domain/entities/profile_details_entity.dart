import 'package:equatable/equatable.dart';

class ProfileDetailsEntity extends Equatable {
  const ProfileDetailsEntity({
    required this.id,
    required this.birthDate,
    required this.weight,
    required this.height,
    required this.cycleAvgLength,
    required this.periodAvgLength,
    required this.lastPeriodDateStart,
    required this.createdAt,
    required this.updatedAt,
    this.lastPeriodDateEnd,
  });

  final String id;
  final DateTime birthDate;
  final int weight;
  final int height;
  final int cycleAvgLength;
  final int periodAvgLength;
  final DateTime lastPeriodDateStart;
  final DateTime? lastPeriodDateEnd;

  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    id,
    createdAt,
    updatedAt,
  ];
}
