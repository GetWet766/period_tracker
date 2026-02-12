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
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/calendar/presentation/widgets/calendar.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/entities/day_info.dart';
import 'package:periodility/features/cycle/domain/services/cycle_calculator.dart';
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
    // final textTheme = TextTheme.of(context);

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
                      lastPeriodStart: state.currentCycle?.startDate,
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
                          // Remove dummy section container
                          // const SectionContainer(title: 'Запись', ...),
                          // Remove dummy notes
                          SectionContainer(
                            title: 'Заметки',
                            child: TextFormField(
                              // Use logsState value? Or controller handling in a separate widget/method
                              initialValue: selectedDayLog?.notes,
                              // Logic to save notes needs a debouncer or save button.
                              // Simple 'read only' for now or Basic field.
                              decoration: InputDecoration(
                                labelText: selectedDayLog?.notes != null
                                    ? null
                                    : 'Нет заметок',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              readOnly:
                                  true, // For now since we don't have save logic hooked up in this precise widget tree spot without local state management
                            ),
                          ),
                          // _buildLogDetailsSection(context, selectedDayLog), // Can implement if needed
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
        margin: const .only(bottom: 16),
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
            ), // You might want to map colors/icons based on phase
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
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

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

  // Widget _buildLogDetailsSection(BuildContext context, CycleLogEntity log) {
  //   final colorScheme = ColorScheme.of(context);
  //   final textTheme = TextTheme.of(context);

  //   return SectionContainer(
  //     title: 'Записанные данные',
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: colorScheme.surfaceContainerLow,
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         spacing: 12,
  //         children: [
  //           if (log.flowLevel != null)
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.water_drop,
  //                   color: colorScheme.primary,
  //                   size: 20,
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Text(
  //                   'Интенсивность: ${log.flowLevel!.displayName}',
  //                   style: textTheme.bodyMedium,
  //                 ),
  //               ],
  //             ),
  //           if (log.symptoms.isNotEmpty) ...[
  //             Text(
  //               'Симптомы:',
  //               style: textTheme.bodyMedium?.copyWith(
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             Wrap(
  //               spacing: 8,
  //               runSpacing: 4,
  //               children: log.symptoms.map((symptom) {
  //                 return Chip(
  //                   label: Text(symptom),
  //                   visualDensity: VisualDensity.compact,
  //                 );
  //               }).toList(),
  //             ),
  //           ],
  //           if (log.notes != null && log.notes!.isNotEmpty)
  //             Text(
  //               'Заметки: ${log.notes}',
  //               style: textTheme.bodyMedium,
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildAddLogButton(BuildContext context) {
  //   return FilledButton.icon(
  //     onPressed: () => _showAddLogDialog(context),
  //     icon: const Icon(Icons.add),
  //     label: Text(
  //       _getLogForDate(
  //                 context.read<CycleCubit>().state.maybeWhen(
  //                   loaded: (l) => l,
  //                   orElse: () => [],
  //                 ),
  //                 selectedDay,
  //               ) !=
  //               null
  //           ? 'Редактировать запись'
  //           : 'Добавить запись',
  //     ),
  //   );
  // }

  // Future<void> _showAddLogDialog(BuildContext context) async {
  //   final existingLog = _getLogForDate(
  //     context.read<CycleCubit>().state.maybeWhen(
  //       loaded: (l) => l,
  //       orElse: () => [],
  //     ),
  //     selectedDay,
  //   );

  //   final symptoms = List<String>.from(existingLog?.symptoms ?? []);
  //   var selectedFlow = existingLog?.flowLevel;
  //   var notes = existingLog?.notes ?? '';

  //   await showModalBottomSheet<void>(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) => StatefulBuilder(
  //       builder: (context, setModalState) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //             bottom: MediaQuery.of(context).viewInsets.bottom,
  //           ),
  //           child: Container(
  //             padding: const EdgeInsets.all(24),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 Text(
  //                   DateFormat('d MMMM yyyy').format(selectedDay),
  //                   style: const TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 const Text('Интенсивность:'),
  //                 const SizedBox(height: 8),
  //                 Wrap(
  //                   spacing: 8,
  //                   children: FlowLevel.values.map((flow) {
  //                     final isSelected = selectedFlow == flow;
  //                     return ChoiceChip(
  //                       label: Text(flow.displayName),
  //                       selected: isSelected,
  //                       onSelected: (selected) {
  //                         setModalState(() {
  //                           selectedFlow = selected ? flow : null;
  //                         });
  //                       },
  //                     );
  //                   }).toList(),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 const Text('Симптомы:'),
  //                 const SizedBox(height: 8),
  //                 Wrap(
  //                   spacing: 8,
  //                   children:
  //                       [
  //                         'Спазмы',
  //                         'Головная боль',
  //                         'Усталость',
  //                         'Вздутие',
  //                         'Перепады настроения',
  //                         'Боль в спине',
  //                       ].map((symptom) {
  //                         final isSelected = symptoms.contains(symptom);
  //                         return FilterChip(
  //                           label: Text(symptom),
  //                           selected: isSelected,
  //                           onSelected: (selected) {
  //                             setModalState(() {
  //                               if (selected) {
  //                                 symptoms.add(symptom);
  //                               } else {
  //                                 symptoms.remove(symptom);
  //                               }
  //                             });
  //                           },
  //                         );
  //                       }).toList(),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 TextField(
  //                   decoration: const InputDecoration(
  //                     labelText: 'Заметки',
  //                     border: OutlineInputBorder(),
  //                   ),
  //                   maxLines: 2,
  //                   controller: TextEditingController(text: notes),
  //                   onChanged: (value) => notes = value,
  //                 ),
  //                 const SizedBox(height: 24),
  //                 Row(
  //                   spacing: 12,
  //                   children: [
  //                     if (existingLog != null)
  //                       Expanded(
  //                         child: OutlinedButton(
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                             _deleteLog(existingLog.id);
  //                           },
  //                           child: const Text('Удалить'),
  //                         ),
  //                       ),
  //                     Expanded(
  //                       child: FilledButton(
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                           _saveLog(
  //                             existingLog?.id,
  //                             selectedFlow,
  //                             symptoms,
  //                             notes,
  //                           );
  //                         },
  //                         child: const Text('Сохранить'),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // Future<void> _saveLog(
  //   String? existingId,
  //   FlowLevel? flow,
  //   List<String> symptoms,
  //   String notes,
  // ) async {
  //   if (existingId != null) {
  //     await context.read<CycleCubit>().updateLog(
  //       id: existingId,
  //       flowLevel: flow,
  //       symptoms: symptoms.isNotEmpty ? symptoms : null,
  //       notes: notes.isNotEmpty ? notes : null,
  //     );
  //   } else {
  //     await context.read<CycleCubit>().createLog(
  //       date: selectedDay,
  //       flowLevel: flow,
  //       symptoms: symptoms.isNotEmpty ? symptoms : null,
  //       notes: notes.isNotEmpty ? notes : null,
  //     );
  //   }

  //   if (mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Данные сохранены')),
  //     );
  //   }
  // }

  // Future<void> _deleteLog(String id) async {
  //   await context.read<CycleCubit>().deleteLog(id);
  //   if (mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Запись удалена')),
  //     );
  //   }
  // }

  // PeriodConfig _buildPeriodConfig(
  //   List<CycleLogEntity> logs,
  //   int cycleLength,
  //   int periodLength,
  // ) {
  //   DateTime? lastPeriodStart;

  //   if (logs.isNotEmpty) {
  //     final sortedLogs = List<CycleLogEntity>.from(logs)
  //       ..sort((a, b) => b.date.compareTo(a.date));

  //     for (final log in sortedLogs) {
  //       if (log.flowLevel != null) {
  //         lastPeriodStart = log.date;
  //         break;
  //       }
  //     }
  //   }

  //   return PeriodConfig(
  //     lastPeriodStart: lastPeriodStart,
  //     cycleLength: cycleLength,
  //     periodDuration: periodLength,
  //   );
  // }

  // CycleLogEntity? _getLogForDate(List<CycleLogEntity> logs, DateTime date) {
  //   final normalizedDate = DateTime(date.year, date.month, date.day);
  //   for (final log in logs) {
  //     final logDate = DateTime(log.date.year, log.date.month, log.date.day);
  //     if (logDate == normalizedDate) {
  //       return log;
  //     }
  //   }
  //   return null;
  // }
}
