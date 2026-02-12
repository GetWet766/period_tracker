import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:periodility/features/calendar/presentation/widgets/weekday_card.dart';
import 'package:periodility/features/calendar/presentation/widgets/weekday_label_card.dart';

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
