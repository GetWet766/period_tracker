import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_state.dart';
import 'package:period_tracker/features/home/presentation/widgets/phase_card.dart';
import 'package:period_tracker/features/home/presentation/widgets/phase_list.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

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

              final cycleInfo = _calculateCycleInfo(
                logs,
                profile?.cycleAvgLength ?? 28,
                profile?.periodAvgLength ?? 5,
              );

              return CustomScrollView(
                slivers: [
                  TrackerAppBar(
                    title: Text(DateFormat('d MMMM').format(DateTime.now())),
                    actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
                    actions: [
                      IconButton.filled(
                        onPressed: () => context.push('/profile'),
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedUser03,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 16,
                      ),
                      child: Column(
                        children: [
                          Text(
                            cycleInfo.isPeriodActive
                                ? 'День менструации:'
                                : 'До начала менструации осталось:',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cycleInfo.isPeriodActive
                                ? '${cycleInfo.currentPeriodDay}'
                                : '${cycleInfo.daysUntilPeriod} дней',
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
                            onPressed: () => _togglePeriod(cycleInfo),
                            label: Text(
                              cycleInfo.isPeriodActive
                                  ? 'Закончились'
                                  : 'Начались',
                            ),
                            icon: const HugeIcon(
                              icon: HugeIcons.strokeRoundedGiveBlood,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FilledButton(
                            onPressed: () => _showSymptomsDialog(context),
                            child: const Text(
                              'Как Вы себя чувствуете сегодня?',
                            ),
                          ),
                        ],
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
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 16,
                        children: [
                          _buildPhasesSection(
                            colorScheme,
                            cycleInfo,
                          ),
                          _buildPartnerSection(colorScheme, textTheme),
                          _buildProgressSection(
                            colorScheme,
                            textTheme,
                            cycleInfo,
                          ),
                          _buildCyclesInfoSection(
                            colorScheme,
                            textTheme,
                            profile?.periodAvgLength ?? 5,
                            profile?.cycleAvgLength ?? 28,
                          ),
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

  Widget _buildPhasesSection(ColorScheme colorScheme, _CycleInfo cycleInfo) {
    return SectionContainer(
      title: 'Фазы цикла',
      child: PhaseList(
        children: [
          PhaseCard(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            title: 'Следующий срок зачатия',
            subtitle: DateFormat('d MMMM').format(cycleInfo.fertileWindowStart),
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedPlant01),
          ),
          PhaseCard(
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
            title: 'Овуляция',
            subtitle: DateFormat('d MMMM').format(cycleInfo.ovulationDate),
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedBaby01),
          ),
          PhaseCard(
            backgroundColor: colorScheme.tertiary,
            foregroundColor: colorScheme.onTertiary,
            title: 'Следующая менструация',
            subtitle: DateFormat('d MMMM').format(cycleInfo.nextPeriodDate),
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedGiveBlood),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerSection(ColorScheme colorScheme, TextTheme textTheme) {
    return SectionContainer(
      title: 'Добавьте партнера',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                const CircleAvatar(
                  radius: 26,
                  child: HugeIcon(icon: HugeIcons.strokeRoundedUser03),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  width: 60,
                  height: 2,
                ),
                const CircleAvatar(
                  radius: 26,
                  child: HugeIcon(icon: HugeIcons.strokeRoundedUser03),
                ),
              ],
            ),
            Text(
              'Укрепляйте доверие и заботу - помогите партнеру'
              ' понять, что Вы чувствуете',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            FilledButton(
              onPressed: _invitePartner,
              child: const Text('Пригласить'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(
    ColorScheme colorScheme,
    TextTheme textTheme,
    _CycleInfo cycleInfo,
  ) {
    return SectionContainer(
      title: 'Прогресс цикла',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.surfaceContainerLow,
        ),
        child: Column(
          children: [
            Slider(
              min: 1,
              max: cycleInfo.cycleLength.toDouble(),
              value: cycleInfo.currentCycleDay.toDouble().clamp(
                1,
                cycleInfo.cycleLength.toDouble(),
              ),
              onChanged: null,
            ),
            const SizedBox(height: 8),
            Text(
              'День ${cycleInfo.currentCycleDay} из ${cycleInfo.cycleLength}',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Вероятность беременности - ${cycleInfo.pregnancyProbability}',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCyclesInfoSection(
    ColorScheme colorScheme,
    TextTheme textTheme,
    int periodAvgLength,
    int cycleAvgLength,
  ) {
    return SectionContainer(
      title: 'Мои циклы',
      child: Row(
        spacing: 2,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                  right: Radius.circular(4),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        'Средняя длительность месячных',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '$periodAvgLength дней',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedGiveBlood,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(16),
                  left: Radius.circular(4),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        'Средняя длительность цикла',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '$cycleAvgLength дней',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedReload,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _CycleInfo _calculateCycleInfo(
    List<CycleLogEntity> logs,
    int cycleLength,
    int periodLength,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Find last period start
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

    lastPeriodStart ??= today.subtract(Duration(days: cycleLength ~/ 2));

    final daysSinceLastPeriod = today.difference(lastPeriodStart).inDays;
    final currentCycleDay = (daysSinceLastPeriod % cycleLength) + 1;
    final daysUntilPeriod = cycleLength - currentCycleDay + 1;
    final isPeriodActive = currentCycleDay <= periodLength;

    final nextPeriodDate = today.add(Duration(days: daysUntilPeriod));
    final ovulationDay = cycleLength - 14;
    final daysUntilOvulation = ovulationDay - currentCycleDay;
    final ovulationDate = today.add(Duration(days: daysUntilOvulation));
    final fertileWindowStart = ovulationDate.subtract(const Duration(days: 5));

    String pregnancyProbability;
    if (currentCycleDay <= periodLength) {
      pregnancyProbability = 'очень низкая';
    } else if (currentCycleDay >= ovulationDay - 5 &&
        currentCycleDay <= ovulationDay + 1) {
      pregnancyProbability = 'высокая';
    } else if (currentCycleDay >= ovulationDay - 7 &&
        currentCycleDay <= ovulationDay + 3) {
      pregnancyProbability = 'средняя';
    } else {
      pregnancyProbability = 'низкая';
    }

    return _CycleInfo(
      currentCycleDay: currentCycleDay,
      daysUntilPeriod: daysUntilPeriod,
      isPeriodActive: isPeriodActive,
      currentPeriodDay: isPeriodActive ? currentCycleDay : 0,
      nextPeriodDate: nextPeriodDate,
      ovulationDate: ovulationDate,
      fertileWindowStart: fertileWindowStart,
      cycleLength: cycleLength,
      pregnancyProbability: pregnancyProbability,
    );
  }

  Future<void> _togglePeriod(_CycleInfo cycleInfo) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (cycleInfo.isPeriodActive) {
      // End period - no action needed, just informational
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Менструация завершена')),
      );
    } else {
      final cycleCubit = context.read<CycleCubit>();
      // Start period
      await cycleCubit.createLog(
        date: DateTime.now(),
        flowLevel: FlowLevel.medium,
      );
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Менструация началась')),
      );
    }
  }

  Future<void> _showSymptomsDialog(BuildContext context) async {
    final symptoms = <String>[];
    FlowLevel? selectedFlow;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          final colorScheme = ColorScheme.of(context);
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
                  const Text(
                    'Как Вы себя чувствуете?',
                    style: TextStyle(
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
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await _saveTodayLog(selectedFlow, symptoms);
                    },
                    child: const Text('Сохранить'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveTodayLog(FlowLevel? flow, List<String> symptoms) async {
    if (flow == null && symptoms.isEmpty) return;
    final cycleCubit = context.read<CycleCubit>();

    await cycleCubit.createLog(
      date: DateTime.now(),
      flowLevel: flow,
      symptoms: symptoms.isNotEmpty ? symptoms : null,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные сохранены')),
      );
    }
  }

  Future<void> _invitePartner() async {
    await context.push('/invite-partner');
  }
}

class _CycleInfo {
  const _CycleInfo({
    required this.currentCycleDay,
    required this.daysUntilPeriod,
    required this.isPeriodActive,
    required this.currentPeriodDay,
    required this.nextPeriodDate,
    required this.ovulationDate,
    required this.fertileWindowStart,
    required this.cycleLength,
    required this.pregnancyProbability,
  });

  final int currentCycleDay;
  final int daysUntilPeriod;
  final bool isPeriodActive;
  final int currentPeriodDay;
  final DateTime nextPeriodDate;
  final DateTime ovulationDate;
  final DateTime fertileWindowStart;
  final int cycleLength;
  final String pregnancyProbability;
}
