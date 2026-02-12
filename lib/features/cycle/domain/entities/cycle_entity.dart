import 'package:equatable/equatable.dart';

enum CyclePhase { menstruation, follicular, ovulation, luteal }

class CycleEntity extends Equatable {
  const CycleEntity({
    required this.id,
    required this.startDate,
    required this.isManuallyStarted,
    this.userId,
    this.endDate,
    this.avg,
    this.phase,
    this.daysTo,
  });

  final String id;
  final String? userId;
  final DateTime startDate;
  final DateTime? endDate;
  final int? avg;
  final CyclePhase? phase;
  final int? daysTo;
  final bool isManuallyStarted;

  CycleEntity copyWith({
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    int? avg,
    CyclePhase? phase,
    int? daysTo,
    bool? isManuallyStarted,
  }) {
    return CycleEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      avg: avg ?? this.avg,
      phase: phase ?? this.phase,
      daysTo: daysTo ?? this.daysTo,
      isManuallyStarted: isManuallyStarted ?? this.isManuallyStarted,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    startDate,
    endDate,
    avg,
    phase,
    daysTo,
    isManuallyStarted,
  ];
}
