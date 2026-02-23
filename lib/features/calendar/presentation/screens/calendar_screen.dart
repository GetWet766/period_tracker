import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:periodility/core/common/widgets/widgets.dart';
import 'package:periodility/core/constants/log_constants.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/core/l10n/l10n_mapper.dart';
import 'package:periodility/core/services/analytics_service.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/calendar/presentation/widgets/calendar.dart';
import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/entities/day_info.dart';
import 'package:periodility/features/cycle/domain/services/cycle_calculator.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/features/cycle/presentation/cubit/daily_logs_cubit.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  static const routePath = '/calendar';
  static const routeName = 'calendar';

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    sl<AnalyticsService>().logScreenView('Calendar');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Scaffold(
      body: ParallaxSnapSheet(
        sliverAppBar: TrackerAppBar(title: Text(context.l10n.nav_calendar)),
        backgroundContent: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<CycleCubit, CycleState>(
            builder: (context, state) {
              return Calendar(
                periodConfig: PeriodConfig(
                  currentCycle: state.currentCycle,
                  history: state.history,
                ),
                selectedDay: selectedDay,
                onSelectedDayChanged: (value) async {
                  setState(() {
                    selectedDay = value;
                  });
                  await context.read<DailyLogsCubit>().loadLogForDate(value);
                },
              );
            },
          ),
        ),
        sheetContent: BlocBuilder<CycleCubit, CycleState>(
          builder: (context, cycleState) {
            return BlocBuilder<DailyLogsCubit, DailyLogsState>(
              builder: (context, logsState) {
                final cycleCalculator = sl<CycleCalculator>();
                final currentCycle = cycleState.currentCycle;
                final avgCycle = currentCycle?.avg ?? 28;

                final dayInfo = cycleCalculator.getDayInfo(
                  selectedDay,
                  currentCycle,
                  history: cycleState.history,
                  cycleLength: avgCycle,
                );

                final selectedDayLog = logsState.selectedLog;

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
                      SectionContainer(
                        title: context.l10n.recorded_data,
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
                            context.l10n.add_record,
                            style: textTheme.bodyLarge,
                          ),
                        ),
                      )
                    else
                      _buildLogDetailsSection(
                        context,
                        selectedDayLog,
                      ),
                    const AppBannerAd(),
                  ],
                );
              },
            );
          },
        ),
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

    return context.l10n.calendarDayInfo(formattedDate, isToday.toString());
  }

  Widget _buildDayInfoSection(
    BuildContext context,
    DayInfo? dayInfo,
    DailyLogEntity? log,
  ) {
    if (dayInfo == null) {
      return const SizedBox.shrink();
    }

    final nowDate = DateTime.now();
    final isToday =
        dayInfo.date.year == nowDate.year &&
        dayInfo.date.month == nowDate.month &&
        dayInfo.date.day == nowDate.day;

    return SectionContainer(
      title: context.l10n.calendarDayInfo(
        DateFormat(
          'd MMMM',
          context.l10n.localeName,
        ).format(dayInfo.date),
        isToday.toString(),
      ),
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
              context.l10n.cycle_day,
              context.l10n.cycle_day_n(dayInfo.cycleDay.toString()),
              Symbols.calendar_today_rounded,
              Colors.teal,
            ),
            _buildInfoRow(
              context,
              dayInfo.phase.name,
              context.l10n.cycle_phase,
              dayInfo.phaseDescription(context.l10n),
              dayInfo.phaseIcon,
              dayInfo.phaseColor,
            ),
            _buildInfoRow(
              context,
              'pregnancy-probability',
              context.l10n.pregnancy_probability,
              dayInfo.pregnancyProbabilityDescription(context.l10n),
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
      onPressed: () => context.push('/learn/all/$id'),
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
      title: context.l10n.recorded_data,
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
                      '${context.l10n.intensity}: ${log.flowLevels!.map((e) => e.getLocalizedName(context.l10n)).join(', ')}',
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
                    '${context.l10n.mood}: ${translateL10n(log.mood!, context.l10n)}',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            if (log.symptoms != null && log.symptoms!.isNotEmpty) ...[
              Text(
                '${context.l10n.symptoms}:',
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
                          translateL10n(category, context.l10n),
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
                            label: Text(translateL10n(symptom, context.l10n)),
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
                '${context.l10n.notes}:',
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
