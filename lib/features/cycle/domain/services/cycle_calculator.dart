import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/domain/entities/day_info.dart';

class CycleCalculator {
  static const int defaultCycleLength = 28;
  static const int defaultPeriodLength = 5;
  static const int ovulationBeforeNextPeriod = 14;

  int calculateAverageCycleLength(List<CycleEntity> cycles) {
    if (cycles.length < 2) return defaultCycleLength;

    final sortedCycles = List<CycleEntity>.from(cycles)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));

    int totalDays = 0;
    int cycleCount = 0;

    for (int i = 0; i < sortedCycles.length - 1; i++) {
      final current = sortedCycles[i];
      final next = sortedCycles[i + 1];

      final diff = next.startDate.difference(current.startDate).inDays;

      if (diff > 0) {
        totalDays += diff;
        cycleCount++;
      }
    }

    if (cycleCount == 0) return defaultCycleLength;

    return (totalDays / cycleCount).round();
  }

  int calculateAveragePeriodLength(List<CycleEntity> cycles) {
    if (cycles.isEmpty) return defaultPeriodLength;

    final completedPeriods = cycles.where((c) => c.endDate != null).toList();
    if (completedPeriods.isEmpty) return defaultPeriodLength;

    final totalDays = completedPeriods.fold(0, (sum, cycle) {
      // endDate is likely the end of menstruation.
      // If startDate is Jan 1, endDate is Jan 5, duration is 5 days.
      // difference(Jan 5, Jan 1) = 4. So +1.
      return sum + cycle.endDate!.difference(cycle.startDate).inDays + 1;
    });

    return (totalDays / completedPeriods.length).round();
  }

  DayInfo? getDayInfo(
    DateTime date,
    CycleEntity? currentCycle, {
    int cycleLength = defaultCycleLength,
    int periodLength = defaultPeriodLength,
  }) {
    if (currentCycle == null) return null;

    final start = DateTime(
      currentCycle.startDate.year,
      currentCycle.startDate.month,
      currentCycle.startDate.day,
    );
    final checkDate = DateTime(date.year, date.month, date.day);

    final daysDiff = checkDate.difference(start).inDays;

    // Use modulo for days into cycle, but only if daysDiff >= 0.
    // If daysDiff < 0, it means the date is before this cycle started.
    // Ideally we should find the cycle that covers this date.
    // But as a fallback/simplification for "current view" relative to "current cycle":
    if (daysDiff < 0) return null;

    final cycleDay = (daysDiff % cycleLength) + 1;

    // Ovulation calculation
    final ovulationDay = cycleLength - ovulationBeforeNextPeriod;
    final fertileWindowStart = ovulationDay - 5;
    final fertileWindowEnd = ovulationDay + 1;

    // Phase
    CyclePhase
    phase; // Uses CyclePhase from cycle_entity (imported via day_info logic or direct?)
    // Wait, day_info.dart imports cycle_entity.dart which defines CyclePhase.
    // So CyclePhase is available if I import cycle_entity.dart.

    if (cycleDay <= periodLength) {
      phase = CyclePhase.menstruation;
    } else if (cycleDay < fertileWindowStart) {
      phase = CyclePhase.follicular;
    } else if (cycleDay <= fertileWindowEnd) {
      phase = CyclePhase.ovulation;
    } else {
      phase = CyclePhase.luteal;
    }

    // Pregnancy Probability
    PregnancyProbability probability;
    if (cycleDay <= periodLength) {
      probability = PregnancyProbability.none;
    } else if (cycleDay >= fertileWindowStart && cycleDay <= fertileWindowEnd) {
      if (cycleDay == ovulationDay || cycleDay == ovulationDay - 1) {
        probability = PregnancyProbability.high;
      } else {
        probability = PregnancyProbability.medium;
      }
    } else {
      probability = PregnancyProbability.low;
    }

    final daysUntilNextPeriod = cycleLength - cycleDay + 1;

    return DayInfo(
      date: date,
      cycleDay: cycleDay,
      phase: phase,
      pregnancyProbability: probability,
      isMenstruation: cycleDay <= periodLength,
      isOvulationDay: cycleDay == ovulationDay,
      daysUntilNextPeriod: daysUntilNextPeriod,
    );
  }
}
