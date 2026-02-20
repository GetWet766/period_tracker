import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:periodility/features/calendar/presentation/widgets/weekday_card.dart';
import 'package:periodility/features/calendar/presentation/widgets/weekday_label_card.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';

class PeriodConfig {
  const PeriodConfig({
    this.currentCycle,
    this.history = const [],
    this.periodDuration = 5,
    this.cycleLength = 28,
  });

  final CycleEntity? currentCycle;
  final List<CycleEntity> history;
  final int periodDuration;
  final int cycleLength;

  int? getPeriodDayIndex(DateTime date) {
    if (currentCycle == null && history.isEmpty) return null;

    final checkDate = DateTime(date.year, date.month, date.day);

    // 1. Check if date falls within any historical cycle's actual menstruation period
    for (final cycle in history) {
      if (cycle.endDate != null) {
        final start = DateTime(
          cycle.startDate.year,
          cycle.startDate.month,
          cycle.startDate.day,
        );
        final end = DateTime(
          cycle.endDate!.year,
          cycle.endDate!.month,
          cycle.endDate!.day,
        );

        if (!checkDate.isBefore(start) && !checkDate.isAfter(end)) {
          return checkDate.difference(start).inDays + 1;
        }
      }
    }

    // 2. Check current cycle
    if (currentCycle != null) {
      final start = DateTime(
        currentCycle!.startDate.year,
        currentCycle!.startDate.month,
        currentCycle!.startDate.day,
      );

      if (checkDate.isBefore(start)) return null;

      if (currentCycle!.endDate != null) {
        final end = DateTime(
          currentCycle!.endDate!.year,
          currentCycle!.endDate!.month,
          currentCycle!.endDate!.day,
        );

        if (!checkDate.isAfter(end)) {
          return checkDate.difference(start).inDays + 1;
        }

        final daysDiff = checkDate.difference(start).inDays;
        final latestCycleLength = currentCycle!.avg ?? cycleLength;
        final projectedCycleNumber = (daysDiff / latestCycleLength).floor();

        if (projectedCycleNumber > 0) {
          final projectedStart = start.add(
            Duration(days: projectedCycleNumber * latestCycleLength),
          );
          final daysIntoPeriod = checkDate.difference(projectedStart).inDays;
          if (daysIntoPeriod >= 0 && daysIntoPeriod < periodDuration) {
            return daysIntoPeriod + 1;
          }
        }
      } else {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        if (!checkDate.isAfter(today)) {
          return checkDate.difference(start).inDays + 1;
        } else {
          final daysPassed = today.difference(start).inDays + 1;

          if (daysPassed < periodDuration) {
            final predictedEnd = start.add(Duration(days: periodDuration - 1));
            if (!checkDate.isAfter(predictedEnd)) {
              return checkDate.difference(start).inDays + 1;
            }
          }

          final daysDiff = checkDate.difference(start).inDays;
          final latestCycleLength = currentCycle!.avg ?? cycleLength;
          final projectedCycleNumber = (daysDiff / latestCycleLength).floor();

          if (projectedCycleNumber > 0) {
            final projectedStart = start.add(
              Duration(days: projectedCycleNumber * latestCycleLength),
            );
            final daysIntoPeriod = checkDate.difference(projectedStart).inDays;
            if (daysIntoPeriod >= 0 && daysIntoPeriod < periodDuration) {
              return daysIntoPeriod + 1;
            }
          }
        }
      }
    }

    return null;
  }

  int? getPregnancyProbabilityDayIndex(DateTime date) {
    if (currentCycle == null && history.isEmpty) return null;

    final baseCycle = currentCycle ?? history.first;
    final baseStart = DateTime(
      baseCycle.startDate.year,
      baseCycle.startDate.month,
      baseCycle.startDate.day,
    );
    final checkDate = DateTime(date.year, date.month, date.day);

    final daysDiff = checkDate.difference(baseStart).inDays;
    final cLength = baseCycle.avg ?? cycleLength;
    final cycleNumber = (daysDiff / cLength).floor();
    final periodStart = baseStart.add(Duration(days: cycleNumber * cLength));

    final daysIntoPeriod = checkDate.difference(periodStart).inDays;

    if (daysIntoPeriod >= 0 && daysIntoPeriod < 11) {
      return daysIntoPeriod + 1;
    }

    return null;
  }

  bool isPeriod(DateTime date) {
    return getPeriodDayIndex(date) != null;
  }

  int? getCycleDay(DateTime date) {
    if (currentCycle == null && history.isEmpty) return null;

    final baseCycle = currentCycle ?? history.first;
    final normalizedStart = DateTime(
      baseCycle.startDate.year,
      baseCycle.startDate.month,
      baseCycle.startDate.day,
    );
    final checkDate = DateTime(date.year, date.month, date.day);

    final daysDiff = checkDate.difference(normalizedStart).inDays;
    if (daysDiff < 0) return null;

    final cLength = baseCycle.avg ?? cycleLength;
    return (daysDiff % cLength) + 1;
  }
}

class Calendar extends StatefulWidget {
  const Calendar({
    required this.periodConfig,
    this.onSelectedDayChanged,
    this.selectedDay,
    super.key,
  });

  final DateTime? selectedDay;
  final void Function(DateTime value)? onSelectedDayChanged;
  final PeriodConfig periodConfig;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedMonth = DateTime.now();

  // Список дней недели
  final List<String> _weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(
      _focusedMonth.year,
      _focusedMonth.month,
    );
    final firstDayOffset =
        DateTime(_focusedMonth.year, _focusedMonth.month).weekday - 1;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        children: [
          _buildHeader(),
          _buildDaysOfWeek(),
          _buildCalendarGrid(daysInMonth, firstDayOffset),
        ],
      ),
    );
  }

  // Заголовок: Месяц и кнопки управления
  Widget _buildHeader() {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(4),
        color: colorScheme.surface,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('MMMM yyyy').format(_focusedMonth),
            style: textTheme.titleMedium?.copyWith(
              fontWeight: .bold,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(
                  () => _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month - 1,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(
                  () => _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month + 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDaysOfWeek() {
    return Row(
      spacing: 2,
      children: _weekDays.map(
        (day) {
          final isWeekend = day == 'Сб' || day == 'Вс';

          return WeekdayLabelCard(label: day, isWeekend: isWeekend);
        },
      ).toList(),
    );
  }

  // Сетка с числами
  Widget _buildCalendarGrid(int daysInMonth, int offset) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 2, // Вертикальный spacing
        crossAxisSpacing: 2, // Горизонтальный spacing
      ),
      itemCount: daysInMonth + offset,
      itemBuilder: (context, index) {
        if (index < offset) {
          return const SizedBox.shrink(); // Пустые ячейки начала месяца
        }

        final day = index - offset + 1;
        final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
        final isSelected =
            widget.selectedDay != null &&
            DateUtils.isSameDay(widget.selectedDay, date);
        final isToday = DateUtils.isSameDay(DateTime.now(), date);
        final periodDayIndex = widget.periodConfig.getPeriodDayIndex(date);
        final isInRange = periodDayIndex != null;
        // final hasLog = _hasLogForDate(date);

        return GestureDetector(
          onTap: () => widget.onSelectedDayChanged?.call(date),
          child: WeekdayCard(
            isToday: isToday,
            isSelected: isSelected,
            isInRange: isInRange,
            rangeIndex: periodDayIndex?.toString(),
            day: '$day',
          ),
        );
      },
    );
  }

  // bool _hasLogForDate(DateTime date) {
  //   final normalizedDate = DateTime(date.year, date.month, date.day);
  //   for (final log in widget.cycleLogs) {
  //     final logDate = DateTime(log.date.year, log.date.month, log.date.day);
  //     if (logDate == normalizedDate) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
}
