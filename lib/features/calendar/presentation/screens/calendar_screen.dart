import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/features/calendar/presentation/widgets/calendar.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_state.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_state.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();

  bool get isSelectedToday => DateUtils.isSameDay(selectedDay, DateTime.now());

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          return BlocBuilder<CycleCubit, CycleState>(
            builder: (context, cycleState) {
              final profile = profileState.maybeWhen(
                loaded: (p) => p,
                orElse: () => null,
              );
              final logs = cycleState.maybeWhen(
                loaded: (l) => l,
                orElse: () => <CycleLogEntity>[],
              );

              final periodConfig = _buildPeriodConfig(
                logs,
                profile?.details?.cycleAvgLength ?? 28,
                profile?.details?.periodAvgLength ?? 5,
              );

              final dayInfo = periodConfig.getSelectedDayInfo(selectedDay);
              final selectedDayLog = _getLogForDate(logs, selectedDay);

              return CustomScrollView(
                slivers: [
                  const TrackerAppBar(title: Text('Календарь')),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Calendar(
                        periodConfig: periodConfig,
                        selectedDay: selectedDay,
                        cycleLogs: logs,
                        onSelectedDayChanged: (value) {
                          setState(() {
                            selectedDay = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    fillOverscroll: true,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 16,
                        children: [
                          _buildDayInfoSection(
                            context,
                            dayInfo,
                            selectedDayLog,
                          ),
                          if (selectedDayLog != null)
                            _buildLogDetailsSection(
                              context,
                              selectedDayLog,
                            ),
                          _buildAddLogButton(context),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDayInfoSection(
    BuildContext context,
    DayInfo? dayInfo,
    CycleLogEntity? log,
  ) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return SectionContainer(
      title:
          '${isSelectedToday ? 'Сегодня: ' : ''}${DateFormat('d MMMM').format(selectedDay)}',
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          spacing: 2,
          children: dayInfo != null
              ? dayInfo.toDisplayList().map((e) {
                  return Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () => context.push(
                        '/learn/${e.id}',
                        extra: {'label': e.label},
                      ),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: colorScheme.surfaceContainerLow,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.label,
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    e.value,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList()
              : [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: colorScheme.surfaceContainerLow,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Нет информации',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
        ),
      ),
    );
  }

  Widget _buildLogDetailsSection(BuildContext context, CycleLogEntity log) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return SectionContainer(
      title: 'Записанные данные',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            if (log.flowLevel != null)
              Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Интенсивность: ${log.flowLevel!.displayName}',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            if (log.symptoms.isNotEmpty) ...[
              Text(
                'Симптомы:',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: log.symptoms.map((symptom) {
                  return Chip(
                    label: Text(symptom),
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            ],
            if (log.notes != null && log.notes!.isNotEmpty)
              Text(
                'Заметки: ${log.notes}',
                style: textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddLogButton(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => _showAddLogDialog(context),
      icon: const Icon(Icons.add),
      label: Text(
        _getLogForDate(
                  context.read<CycleCubit>().state.maybeWhen(
                    loaded: (l) => l,
                    orElse: () => [],
                  ),
                  selectedDay,
                ) !=
                null
            ? 'Редактировать запись'
            : 'Добавить запись',
      ),
    );
  }

  Future<void> _showAddLogDialog(BuildContext context) async {
    final existingLog = _getLogForDate(
      context.read<CycleCubit>().state.maybeWhen(
        loaded: (l) => l,
        orElse: () => [],
      ),
      selectedDay,
    );

    final symptoms = List<String>.from(existingLog?.symptoms ?? []);
    var selectedFlow = existingLog?.flowLevel;
    var notes = existingLog?.notes ?? '';

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    DateFormat('d MMMM yyyy').format(selectedDay),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Интенсивность:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: FlowLevel.values.map((flow) {
                      final isSelected = selectedFlow == flow;
                      return ChoiceChip(
                        label: Text(flow.displayName),
                        selected: isSelected,
                        onSelected: (selected) {
                          setModalState(() {
                            selectedFlow = selected ? flow : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text('Симптомы:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        [
                          'Спазмы',
                          'Головная боль',
                          'Усталость',
                          'Вздутие',
                          'Перепады настроения',
                          'Боль в спине',
                        ].map((symptom) {
                          final isSelected = symptoms.contains(symptom);
                          return FilterChip(
                            label: Text(symptom),
                            selected: isSelected,
                            onSelected: (selected) {
                              setModalState(() {
                                if (selected) {
                                  symptoms.add(symptom);
                                } else {
                                  symptoms.remove(symptom);
                                }
                              });
                            },
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Заметки',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    controller: TextEditingController(text: notes),
                    onChanged: (value) => notes = value,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    spacing: 12,
                    children: [
                      if (existingLog != null)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _deleteLog(existingLog.id);
                            },
                            child: const Text('Удалить'),
                          ),
                        ),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _saveLog(
                              existingLog?.id,
                              selectedFlow,
                              symptoms,
                              notes,
                            );
                          },
                          child: const Text('Сохранить'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveLog(
    String? existingId,
    FlowLevel? flow,
    List<String> symptoms,
    String notes,
  ) async {
    if (existingId != null) {
      await context.read<CycleCubit>().updateLog(
        id: existingId,
        flowLevel: flow,
        symptoms: symptoms.isNotEmpty ? symptoms : null,
        notes: notes.isNotEmpty ? notes : null,
      );
    } else {
      await context.read<CycleCubit>().createLog(
        date: selectedDay,
        flowLevel: flow,
        symptoms: symptoms.isNotEmpty ? symptoms : null,
        notes: notes.isNotEmpty ? notes : null,
      );
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные сохранены')),
      );
    }
  }

  Future<void> _deleteLog(String id) async {
    await context.read<CycleCubit>().deleteLog(id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Запись удалена')),
      );
    }
  }

  PeriodConfig _buildPeriodConfig(
    List<CycleLogEntity> logs,
    int cycleLength,
    int periodLength,
  ) {
    DateTime? lastPeriodStart;

    if (logs.isNotEmpty) {
      final sortedLogs = List<CycleLogEntity>.from(logs)
        ..sort((a, b) => b.date.compareTo(a.date));

      for (final log in sortedLogs) {
        if (log.flowLevel != null) {
          lastPeriodStart = log.date;
          break;
        }
      }
    }

    return PeriodConfig(
      lastPeriodStart: lastPeriodStart,
      cycleLength: cycleLength,
      periodDuration: periodLength,
    );
  }

  CycleLogEntity? _getLogForDate(List<CycleLogEntity> logs, DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    for (final log in logs) {
      final logDate = DateTime(log.date.year, log.date.month, log.date.day);
      if (logDate == normalizedDate) {
        return log;
      }
    }
    return null;
  }
}
