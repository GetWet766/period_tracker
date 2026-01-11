import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/features/calendar/presentation/widgets/weekday_card.dart';
import 'package:period_tracker/features/calendar/presentation/widgets/weekday_label_card.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';

enum PregnancyProbability { none, low, medium, high }

enum CyclePhase { menstruation, follicular, ovulation, luteal }

class DayInfoItem {
  const DayInfoItem({
    required this.id,
    required this.label,
    required this.value,
    this.icon,
    this.color,
  });

  final String id;
  final String label;
  final String value;
  final IconData? icon;
  final Color? color;
}

class DayInfo {
  const DayInfo({
    required this.date,
    required this.cycleDay,
    required this.phase,
    required this.pregnancyProbability,
    this.isMenstruation = false,
    this.isOvulationDay = false,
    this.daysUntilNextPeriod,
  });

  final DateTime date;
  final int cycleDay;
  final CyclePhase phase;
  final PregnancyProbability pregnancyProbability;
  final bool isMenstruation;
  final bool isOvulationDay;
  final int? daysUntilNextPeriod;

  String get phaseDescription {
    switch (phase) {
      case CyclePhase.menstruation:
        return 'Менструация';
      case CyclePhase.follicular:
        return 'Фолликулярная фаза';
      case CyclePhase.ovulation:
        return 'Овуляция';
      case CyclePhase.luteal:
        return 'Лютеиновая фаза';
    }
  }

  String get pregnancyProbabilityDescription {
    switch (pregnancyProbability) {
      case PregnancyProbability.none:
        return 'Очень низкая';
      case PregnancyProbability.low:
        return 'Низкая';
      case PregnancyProbability.medium:
        return 'Средняя';
      case PregnancyProbability.high:
        return 'Высокая';
    }
  }

  Color get pregnancyProbabilityColor {
    switch (pregnancyProbability) {
      case PregnancyProbability.none:
        return Colors.grey;
      case PregnancyProbability.low:
        return Colors.green;
      case PregnancyProbability.medium:
        return Colors.orange;
      case PregnancyProbability.high:
        return Colors.red;
    }
  }

  String get phaseId {
    switch (phase) {
      case CyclePhase.menstruation:
        return 'menstruation';
      case CyclePhase.follicular:
        return 'follicular';
      case CyclePhase.ovulation:
        return 'ovulation';
      case CyclePhase.luteal:
        return 'luteal';
    }
  }

  /// Returns a list of info items for display in UI
  List<DayInfoItem> toDisplayList() {
    return [
      DayInfoItem(
        id: 'cycle-day',
        label: 'День цикла',
        value: '$cycleDay',
        icon: Icons.calendar_today,
      ),
      DayInfoItem(
        id: phaseId,
        label: 'Фаза',
        value: phaseDescription,
        icon: isMenstruation ? Icons.water_drop : Icons.circle_outlined,
        color: isMenstruation ? Colors.red : null,
      ),
      DayInfoItem(
        id: 'pregnancy-probability',
        label: 'Вероятность беременности',
        value: pregnancyProbabilityDescription,
        icon: Icons.favorite,
        color: pregnancyProbabilityColor,
      ),
      if (isOvulationDay)
        const DayInfoItem(
          id: 'ovulation',
          label: 'Овуляция',
          value: 'Сегодня',
          icon: Icons.egg_alt,
          color: Colors.purple,
        ),
      if (daysUntilNextPeriod != null)
        DayInfoItem(
          id: 'next-period',
          label: 'До следующей менструации',
          value: '$daysUntilNextPeriod дн.',
          icon: Icons.schedule,
        ),
    ];
  }
}

class PeriodConfig {
  const PeriodConfig({
    this.lastPeriodStart,
    this.periodDuration = 5,
    this.cycleLength = 28,
  });

  final DateTime? lastPeriodStart;
  final int periodDuration;
  final int cycleLength;

  int? getPeriodDayIndex(DateTime date) {
    if (this.lastPeriodStart == null) return null;

    final lastPeriodStart = DateTime(
      this.lastPeriodStart!.year,
      this.lastPeriodStart!.month,
      this.lastPeriodStart!.day,
    );
    final checkDate = DateTime(date.year, date.month, date.day);

    // Calculate days since last period start
    final daysDiff = checkDate.difference(lastPeriodStart).inDays;

    // Find which cycle this date falls into
    final cycleNumber = (daysDiff / cycleLength).floor();

    // Calculate the start of the period for this cycle
    final periodStart = lastPeriodStart.add(
      Duration(days: cycleNumber * cycleLength),
    );

    // Check if date is within this period
    final daysIntoPeriod = checkDate.difference(periodStart).inDays;

    if (daysIntoPeriod >= 0 && daysIntoPeriod < periodDuration) {
      return daysIntoPeriod + 1; // 1-based index
    }

    return null;
  }

  int? getPregnancyProbabilityDayIndex(DateTime date) {
    if (this.lastPeriodStart == null) return null;

    final lastPeriodStart = DateTime(
      this.lastPeriodStart!.year,
      this.lastPeriodStart!.month,
      this.lastPeriodStart!.day,
    );
    final checkDate = DateTime(date.year, date.month, date.day);

    // Calculate days since last period start
    final daysDiff = checkDate.difference(lastPeriodStart).inDays;

    // Find which cycle this date falls into
    final cycleNumber = (daysDiff / cycleLength).floor();

    // Calculate the start of the period for this cycle
    final periodStart = lastPeriodStart.add(
      Duration(days: cycleNumber * cycleLength),
    );

    // Check if date is within this period
    final daysIntoPeriod = checkDate.difference(periodStart).inDays;

    if (daysIntoPeriod >= 0 && daysIntoPeriod < 11) {
      return daysIntoPeriod + 1; // 1-based index
    }

    return null;
  }

  bool isPeriod(DateTime date) {
    return getPeriodDayIndex(date) != null;
  }

  /// Returns the day number within the current cycle (1-based)
  int? getCycleDay(DateTime date) {
    if (lastPeriodStart == null) return null;

    final normalizedStart = DateTime(
      lastPeriodStart!.year,
      lastPeriodStart!.month,
      lastPeriodStart!.day,
    );
    final checkDate = DateTime(date.year, date.month, date.day);

    final daysDiff = checkDate.difference(normalizedStart).inDays;
    if (daysDiff < 0) return null;

    return (daysDiff % cycleLength) + 1;
  }

  /// Returns detailed info about the selected day
  DayInfo? getSelectedDayInfo(DateTime date) {
    if (lastPeriodStart == null) return null;

    final cycleDay = getCycleDay(date);
    if (cycleDay == null) return null;

    // Ovulation typically occurs around day 14 (cycleLength - 14)
    final ovulationDay = cycleLength - 14;
    final fertileWindowStart = ovulationDay - 5;
    final fertileWindowEnd = ovulationDay + 1;

    // Determine cycle phase
    CyclePhase phase;
    if (cycleDay <= periodDuration) {
      phase = CyclePhase.menstruation;
    } else if (cycleDay < fertileWindowStart) {
      phase = CyclePhase.follicular;
    } else if (cycleDay <= fertileWindowEnd) {
      phase = CyclePhase.ovulation;
    } else {
      phase = CyclePhase.luteal;
    }

    // Determine pregnancy probability
    PregnancyProbability probability;
    if (cycleDay <= periodDuration) {
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

    // Calculate days until next period
    final daysUntilNextPeriod = cycleLength - cycleDay + 1;

    return DayInfo(
      date: date,
      cycleDay: cycleDay,
      phase: phase,
      pregnancyProbability: probability,
      isMenstruation: cycleDay <= periodDuration,
      isOvulationDay: cycleDay == ovulationDay,
      daysUntilNextPeriod: daysUntilNextPeriod,
    );
  }
}

class Calendar extends StatefulWidget {
  const Calendar({
    required this.periodConfig,
    this.onSelectedDayChanged,
    this.selectedDay,
    this.cycleLogs = const [],
    super.key,
  });

  final DateTime? selectedDay;
  final void Function(DateTime value)? onSelectedDayChanged;
  final PeriodConfig periodConfig;
  final List<CycleLogEntity> cycleLogs;

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
        final hasLog = _hasLogForDate(date);

        return GestureDetector(
          onTap: () => widget.onSelectedDayChanged?.call(date),
          child: WeekdayCard(
            isToday: isToday,
            isSelected: isSelected,
            isInRange: isInRange,
            hasLog: hasLog,
            rangeIndex: periodDayIndex?.toString(),
            day: '$day',
          ),
        );
      },
    );
  }

  bool _hasLogForDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    for (final log in widget.cycleLogs) {
      final logDate = DateTime(log.date.year, log.date.month, log.date.day);
      if (logDate == normalizedDate) {
        return true;
      }
    }
    return false;
  }
}
