import 'package:equatable/equatable.dart';
import 'package:periodility/features/cycle/domain/entities/flow_level.dart';

class DailyLogEntity extends Equatable {
  const DailyLogEntity({
    required this.id,
    required this.date,
    this.userId,
    this.symptoms,
    this.mood,
    this.notes,
    this.flowLevels,
  });

  final String id;
  final String? userId;
  final DateTime date;
  final List<String>? symptoms;
  final String? mood;
  final String? notes;
  final List<FlowLevel>? flowLevels;

  @override
  List<Object?> get props => [
    id,
    userId,
    date,
    symptoms,
    mood,
    notes,
    flowLevels,
  ];
}
