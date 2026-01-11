import 'package:equatable/equatable.dart';

enum FlowLevel {
  spotting,
  light,
  medium,
  heavy
  ;

  String get displayName {
    switch (this) {
      case FlowLevel.spotting:
        return 'Мажущие';
      case FlowLevel.light:
        return 'Лёгкие';
      case FlowLevel.medium:
        return 'Средние';
      case FlowLevel.heavy:
        return 'Обильные';
    }
  }

  String toJson() => name;

  static FlowLevel? fromString(String? value) {
    if (value == null) return null;
    return FlowLevel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => FlowLevel.medium,
    );
  }
}

class CycleLogEntity extends Equatable {
  const CycleLogEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.createdAt,
    this.flowLevel,
    this.symptoms = const [],
    this.notes,
  });

  final String id;
  final String userId;
  final DateTime date;
  final FlowLevel? flowLevel;
  final List<String> symptoms;
  final String? notes;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    id,
    userId,
    date,
    flowLevel,
    symptoms,
    notes,
    createdAt,
  ];
}
