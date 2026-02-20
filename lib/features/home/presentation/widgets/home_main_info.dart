import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/cycle/presentation/cubit/daily_logs_cubit.dart';

class HomeMainInfo extends StatefulWidget {
  const HomeMainInfo({super.key});

  @override
  State<HomeMainInfo> createState() => _HomeMainInfoState();
}

class _HomeMainInfoState extends State<HomeMainInfo> {
  DailyLogEntity? _todayLog;

  @override
  void initState() {
    super.initState();
    context.read<DailyLogsCubit>().loadLogForDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return BlocConsumer<DailyLogsCubit, DailyLogsState>(
      listener: (context, logState) {
        final now = DateTime.now();
        if (logState.selectedDate.year == now.year &&
            logState.selectedDate.month == now.month &&
            logState.selectedDate.day == now.day) {
          setState(() {
            _todayLog = logState.currentLog;
          });
        }
      },
      builder: (context, logState) {
        final now = DateTime.now();
        if (logState.selectedDate.year == now.year &&
            logState.selectedDate.month == now.month &&
            logState.selectedDate.day == now.day) {
          _todayLog = logState.currentLog;
        }

        return BlocSelector<CycleCubit, CycleState, CycleEntity?>(
          selector: (state) => state.currentCycle,
          builder: (context, state) {
            final hasCurrentCycle = state != null;
            final isPeriodActive = hasCurrentCycle && state.endDate == null;

            final daysTo = state?.daysTo ?? 0;
            final currentMenstruationDay = state != null
                ? DateTime.now()
                          .difference(
                            DateTime(
                              state.startDate.year,
                              state.startDate.month,
                              state.startDate.day,
                            ),
                          )
                          .inDays +
                      1
                : 0;

            final topText = isPeriodActive
                ? context.l10n.today_is_period_day
                : (hasCurrentCycle
                      ? context.l10n.days_until_period_top
                      : context.l10n.no_info);

            final bottomText = isPeriodActive
                ? context.l10n.period_day_number(currentMenstruationDay)
                : (hasCurrentCycle
                      ? context.l10n.days_until_period(daysTo)
                      : context.l10n.no_info);

            final log = _todayLog;
            final hasLogData =
                log != null &&
                ((log.flowLevels?.isNotEmpty ?? false) ||
                    (log.symptoms?.isNotEmpty ?? false) ||
                    log.mood != null ||
                    (log.notes?.isNotEmpty ?? false));

            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    topText,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bottomText,
                    style: textTheme.displaySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.tonalIcon(
                    style: FilledButton.styleFrom(
                      fixedSize: const Size.fromHeight(56),
                      textStyle: textTheme.titleMedium,
                      iconSize: 24,
                    ),
                    onPressed: () => _togglePeriod(isPeriodActive),
                    label: Text(
                      isPeriodActive ? 'Закончились' : 'Начались',
                    ),
                    icon: const Icon(Symbols.water_drop_rounded),
                  ),
                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: () {
                      final dateStr = DateTime.now().toIso8601String();
                      context.push('/calendar/add-log?date=$dateStr');
                    },
                    child: ColoredBox(
                      color: Colors
                          .transparent, // Ensures the whole area is tappable
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!hasLogData)
                            FilledButton(
                              onPressed: () {
                                final dateStr = DateTime.now()
                                    .toIso8601String();
                                context.push('/calendar/add-log?date=$dateStr');
                              },
                              child: Text(
                                context.l10n.how_do_you_feel_today,
                              ),
                            )
                          else
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                if (log.flowLevels != null)
                                  ...log.flowLevels!.map(
                                    (flow) => FilterChip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          9999,
                                        ),
                                      ),
                                      label: Text(flow.displayName),
                                      selected: true,
                                      onSelected: (_) {
                                        final dateStr = DateTime.now()
                                            .toIso8601String();
                                        context.push(
                                          '/calendar/add-log?date=$dateStr',
                                        );
                                      },
                                    ),
                                  ),
                                if (log.mood != null)
                                  FilterChip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9999),
                                    ),
                                    label: Text(log.mood!),
                                    selected: true,
                                    onSelected: (_) {
                                      final dateStr = DateTime.now()
                                          .toIso8601String();
                                      context.push(
                                        '/calendar/add-log?date=$dateStr',
                                      );
                                    },
                                  ),
                                if (log.symptoms != null)
                                  ...log.symptoms!
                                      .take(3)
                                      .map(
                                        (symptom) => FilterChip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              9999,
                                            ),
                                          ),
                                          label: Text(symptom),
                                          selected: true,
                                          onSelected: (_) {
                                            final dateStr = DateTime.now()
                                                .toIso8601String();
                                            context.push(
                                              '/calendar/add-log?date=$dateStr',
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String getDays(int days) {
    return Intl.plural(
      days,
      one: '$days день',
      few: '$days дня',
      many: '$days дней',
      other: '$days дней',
      locale: 'ru',
    );
  }

  Future<void> _togglePeriod(bool isPeriodActive) async {
    if (isPeriodActive) {
      await context.read<CycleCubit>().endPeriod();
    } else {
      await context.read<CycleCubit>().startPeriod();
    }
  }
}
