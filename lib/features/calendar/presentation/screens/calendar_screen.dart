import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:periodility/core/common/widgets/block_container.dart';
import 'package:periodility/core/common/widgets/custom_list_tile.dart';
import 'package:periodility/core/common/widgets/icon_container.dart';
import 'package:periodility/core/common/widgets/section_container.dart';
import 'package:periodility/core/common/widgets/sliver_fill_overscroll.dart';
import 'package:periodility/core/common/widgets/tracker_app_bar.dart';
import 'package:periodility/core/constants/log_constants.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/calendar/presentation/widgets/calendar.dart';
import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/entities/day_info.dart';
import 'package:periodility/features/cycle/domain/services/cycle_calculator.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/features/cycle/presentation/cubit/daily_logs_cubit.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        keyboardDismissBehavior: .onDrag,
        slivers: [
          const TrackerAppBar(title: Text('Календарь')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<CycleCubit, CycleState>(
                builder: (context, state) {
                  return Calendar(
                    periodConfig: PeriodConfig(
                      currentCycle: state.currentCycle,
                      history: state.history,
                    ),
                    selectedDay: selectedDay,
                    onSelectedDayChanged: (value) {
                      setState(() {
                        selectedDay = value;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: BlockContainer(
              child: BlocBuilder<CycleCubit, CycleState>(
                builder: (context, cycleState) {
                  return BlocBuilder<DailyLogsCubit, DailyLogsState>(
                    builder: (context, logsState) {
                      // Use CycleCalculator from DI or context if available, but simplest is to get it from injection
                      // Since we are in presentation, ideally Logic is in Cubit.
                      // CycleCubit *has* the calculator and *could* expose a method "getDayInfo(date)".
                      // But currently it only exposes 'currentCycle'.
                      // We need 'getDayInfo' for *selected* day, which might be different from 'today'.

                      // Option 1: Add getDayInfo to CycleCubit public API?
                      // Option 2: Use CycleCalculator directly here (requires DI locator `sl<CycleCalculator>()`).

                      // Let's use DI locator for now as quick fix or better, add to CycleCubit.
                      // But CycleCubit state is 'currentCycle' (entity).
                      // We can use the entity + calculator here.
                      // But we need the calculator instance.

                      // Let's assume we can get it via `context.read<CycleCubit>().cycleCalculator` if we made it public? No it's private.

                      // Better: Make the calculation part of the UI logic here since we have the Entity?
                      // No, logic belongs in Domain/Service.

                      // Let's import injection and use `sl<CycleCalculator>()`.

                      final cycleCalculator = sl<CycleCalculator>();
                      final currentCycle = cycleState.currentCycle;
                      final avgCycle = currentCycle?.avg ?? 28;

                      final dayInfo = cycleCalculator.getDayInfo(
                        selectedDay,
                        currentCycle,
                        history: cycleState.history,
                        cycleLength: avgCycle,
                      );

                      // Fetch log for selected day?
                      // DailyLogsCubit has `loadLogForDate`.
                      // Tricky: we need to trigger load when selectedDay changes.
                      // We do that in onSelectedDayChanged.

                      final selectedDayLog = logsState.currentLog;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildDayInfoSection(
                            context,
                            dayInfo,
                            selectedDayLog,
                          ),
                          if (selectedDayLog == null ||
                              ((selectedDayLog.flowLevels?.isEmpty ?? true) &&
                                  (selectedDayLog.symptoms?.isEmpty ?? true) &&
                                  selectedDayLog.mood == null &&
                                  (selectedDayLog.notes?.isEmpty ?? true)))
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: OutlinedButton(
                                onPressed: showCreateLogs,
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  alignment: Alignment.center,
                                  minimumSize: const Size.fromHeight(56),
                                ),
                                child: Text(
                                  'Добавить запись',
                                  style: textTheme.bodyLarge,
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: _buildLogDetailsSection(
                                context,
                                selectedDayLog,
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SliverFillOverscroll(
            child: ColoredBox(color: colorScheme.surface),
          ),
        ],
      ),
    );
  }

  Future<void> showCreateLogs() async {
    final dateStr = selectedDay.toIso8601String();
    await context.push('/calendar/add-log?date=$dateStr');
  }

  String getCalendarDayInfo(DateTime date) {
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;

    final formattedDate = DateFormat(
      'd MMMM',
      context.l10n.localeName,
    ).format(date);

    return context.l10n.calendarDayInfo(isToday.toString(), formattedDate);
  }

  Widget _buildDayInfoSection(
    BuildContext context,
    DayInfo? dayInfo,
    DailyLogEntity? log,
  ) {
    if (dayInfo == null) {
      return const SizedBox.shrink();
    }

    return SectionContainer(
      title:
          '${(dayInfo.date.year == DateTime.now().year && dayInfo.date.month == DateTime.now().month && dayInfo.date.day == DateTime.now().day) ? 'Сегодня: ' : ''}${DateFormat('d MMMM').format(dayInfo.date)}',
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          spacing: 2,
          children: [
            _buildInfoRow(
              context,
              'cycle-day',
              'День цикла',
              '${dayInfo.cycleDay}-й день',
              Symbols.calendar_today_rounded,
              Colors.teal,
            ),
            _buildInfoRow(
              context,
              dayInfo.phase.name,
              'Фаза цикла',
              dayInfo.phaseDescription,
              dayInfo.phaseIcon,
              dayInfo.phaseColor,
            ),
            _buildInfoRow(
              context,
              'pregnancy-probability',
              'Вероятность беременности',
              dayInfo.pregnancyProbabilityDescription,
              Symbols.crib_rounded,
              Colors.pink,
              isDanger: dayInfo.pregnancyDanger,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String id,
    String title,
    String value,
    IconData icon,
    Color color, {
    bool isDanger = false,
  }) {
    return CustomListTile(
      leading: IconContainer(
        color: color,
        icon: icon,
      ),
      title: Text(title),
      subtitle: Text(value),
      trailing: isDanger ? const Icon(Symbols.error_circle_rounded) : null,
      onPressed: () => context.push('/learn/$id'),
    );
  }

  Widget _buildLogDetailsSection(BuildContext context, DailyLogEntity log) {
    if ((log.flowLevels == null || log.flowLevels!.isEmpty) &&
        (log.symptoms == null || log.symptoms!.isEmpty) &&
        log.mood == null &&
        (log.notes == null || log.notes!.isEmpty)) {
      return const SizedBox.shrink();
    }

    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return SectionContainer(
      title: 'Записанные данные',
      onPressed: showCreateLogs,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            if (log.flowLevels != null && log.flowLevels!.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.water_drop,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Интенсивность: ${log.flowLevels!.map((e) => e.displayName).join(', ')}',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            if (log.mood != null)
              Row(
                children: [
                  Icon(
                    Icons.mood,
                    color: colorScheme.tertiary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Настроение: ${log.mood}',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            if (log.symptoms != null && log.symptoms!.isNotEmpty) ...[
              Text(
                'Симптомы:',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              ...LogConstants.symptomsByCategory.entries
                  .where((entry) => entry.value.any(log.symptoms!.contains))
                  .expand((entry) {
                    final category = entry.key;
                    final symptoms =
                        (entry.value.where(log.symptoms!.contains).toList()
                          ..sort());
                    return [
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          category,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: symptoms.map((symptom) {
                          return Chip(
                            label: Text(symptom),
                            visualDensity: VisualDensity.compact,
                          );
                        }).toList(),
                      ),
                    ];
                  }),
            ],
            if (log.notes != null && log.notes!.isNotEmpty) ...[
              if (log.symptoms != null && log.symptoms!.isNotEmpty ||
                  log.mood != null ||
                  (log.flowLevels != null && log.flowLevels!.isNotEmpty))
                const Divider(),
              Text(
                'Заметки:',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                log.notes!,
                style: textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
