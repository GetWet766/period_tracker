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
    List<CycleEntity> history = const [],
    int cycleLength = defaultCycleLength,
    int periodLength = defaultPeriodLength,
  }) {
    if (currentCycle == null && history.isEmpty) return null;

    final baseCycle = currentCycle ?? history.first;
    final start = DateTime(
      baseCycle.startDate.year,
      baseCycle.startDate.month,
      baseCycle.startDate.day,
    );
    final checkDate = DateTime(date.year, date.month, date.day);

    final daysDiff = checkDate.difference(start).inDays;

    if (daysDiff < 0) return null;

    final cLength = baseCycle.avg ?? cycleLength;
    final cycleDay = (daysDiff % cLength) + 1;

    // Determine if it's menstruation
    bool isMenstruation = false;

    // 1. Check history
    for (final cycle in history) {
      if (cycle.endDate != null) {
        final cStart = DateTime(
          cycle.startDate.year,
          cycle.startDate.month,
          cycle.startDate.day,
        );
        final cEnd = DateTime(
          cycle.endDate!.year,
          cycle.endDate!.month,
          cycle.endDate!.day,
        );

        if (!checkDate.isBefore(cStart) && !checkDate.isAfter(cEnd)) {
          isMenstruation = true;
          break;
        }
      }
    }

    // 2. Check current cycle
    if (!isMenstruation && currentCycle != null) {
      final cStart = DateTime(
        currentCycle.startDate.year,
        currentCycle.startDate.month,
        currentCycle.startDate.day,
      );
      if (!checkDate.isBefore(cStart)) {
        if (currentCycle.endDate != null) {
          final cEnd = DateTime(
            currentCycle.endDate!.year,
            currentCycle.endDate!.month,
            currentCycle.endDate!.day,
          );
          if (!checkDate.isAfter(cEnd)) {
            isMenstruation = true;
          } else {
            final projectedCycleNumber = (daysDiff / cLength).floor();
            if (projectedCycleNumber > 0) {
              final projectedStart = cStart.add(
                Duration(days: projectedCycleNumber * cLength),
              );
              final daysIntoPeriod = checkDate
                  .difference(projectedStart)
                  .inDays;
              if (daysIntoPeriod >= 0 && daysIntoPeriod < periodLength) {
                isMenstruation = true;
              }
            }
          }
        } else {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);

          if (!checkDate.isAfter(today)) {
            isMenstruation = true;
          } else {
            final daysPassed = today.difference(cStart).inDays + 1;
            if (daysPassed < periodLength) {
              final predictedEnd = cStart.add(Duration(days: periodLength - 1));
              if (!checkDate.isAfter(predictedEnd)) {
                isMenstruation = true;
              }
            }
            final projectedCycleNumber = (daysDiff / cLength).floor();
            if (projectedCycleNumber > 0) {
              final projectedStart = cStart.add(
                Duration(days: projectedCycleNumber * cLength),
              );
              final daysIntoPeriod = checkDate
                  .difference(projectedStart)
                  .inDays;
              if (daysIntoPeriod >= 0 && daysIntoPeriod < periodLength) {
                isMenstruation = true;
              }
            }
          }
        }
      }
    }

    // Ovulation calculation
    final ovulationDay = cLength - ovulationBeforeNextPeriod;
    final fertileWindowStart = ovulationDay - 5;
    final fertileWindowEnd = ovulationDay + 1;

    CyclePhase phase;
    if (isMenstruation) {
      phase = CyclePhase.menstruation;
    } else if (cycleDay < fertileWindowStart) {
      phase = CyclePhase.follicular;
    } else if (cycleDay <= fertileWindowEnd) {
      phase = CyclePhase.ovulation;
    } else {
      phase = CyclePhase.luteal;
    }

    PregnancyProbability probability;
    if (isMenstruation) {
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

    final daysUntilNextPeriod = cLength - cycleDay + 1;

    return DayInfo(
      date: date,
      cycleDay: cycleDay,
      phase: phase,
      pregnancyProbability: probability,
      isMenstruation: isMenstruation,
      isOvulationDay: cycleDay == ovulationDay,
      daysUntilNextPeriod: daysUntilNextPeriod,
    );
  }
}
