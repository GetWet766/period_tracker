import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/features/home/presentation/widgets/phase_card.dart';
import 'package:period_tracker/features/home/presentation/widgets/phase_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          TrackerAppBar(
            title: const Text('25 декабря'),
            actionsPadding: const .symmetric(horizontal: 8),
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
              padding: const .symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'До начала менструации осталось:',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '8 дней',
                    style: textTheme.displaySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: .bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.tonalIcon(
                    style: FilledButton.styleFrom(
                      fixedSize: const Size.fromHeight(56),
                      textStyle: textTheme.titleMedium,
                      iconSize: 24,
                    ),
                    onPressed: () {},
                    label: const Text('Начались'),
                    icon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedGiveBlood,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('Как Вы себя чувствуете сегодня?'),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              padding: const .all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: .circular(28),
              ),
              child: Column(
                crossAxisAlignment: .stretch,
                spacing: 16,
                children: [
                  SectionContainer(
                    title: 'Фазы цикла',
                    child: PhaseList(
                      children: [
                        PhaseCard(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          title: 'Следующий срок зачатия',
                          subtitle: '3 января',
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedPlant01,
                          ),
                        ),
                        PhaseCard(
                          backgroundColor: colorScheme.secondary,
                          foregroundColor: colorScheme.onSecondary,
                          title: 'Овуляция',
                          subtitle: '8 января',
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedBaby01,
                          ),
                        ),
                        PhaseCard(
                          backgroundColor: colorScheme.tertiary,
                          foregroundColor: colorScheme.onTertiary,
                          title: 'Следующая менструация',
                          subtitle: '22 января',
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedGiveBlood,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SectionContainer(
                    title: 'Добавьте партнера',
                    child: Container(
                      padding: const .all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        borderRadius: .circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: .stretch,
                        spacing: 12,
                        children: [
                          Row(
                            mainAxisAlignment: .center,
                            spacing: 8,
                            children: [
                              const CircleAvatar(
                                radius: 26,
                                child: HugeIcon(
                                  icon: HugeIcons.strokeRoundedUser03,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.onSurfaceVariant,
                                  borderRadius: .circular(2),
                                ),
                                width: 60,
                                height: 2,
                              ),
                              const CircleAvatar(
                                radius: 26,
                                child: HugeIcon(
                                  icon: HugeIcons.strokeRoundedUser03,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Укрепляйте доверие и заботу - помогите партнеру понять, что Вы чувствуете',
                            textAlign: .center,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          FilledButton(
                            onPressed: () {},
                            child: const Text('Пригласить'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SectionContainer(
                    title: 'Прогресс цикла',
                    child: Container(
                      padding: const .all(16),
                      decoration: BoxDecoration(
                        borderRadius: .circular(16),
                        color: colorScheme.surfaceContainerLow,
                      ),
                      child: Column(
                        children: [
                          Slider(
                            min: 1,
                            max: 7,
                            value: 1,
                            year2023: false,
                            onChanged: (value) {},
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Сегодня первый день цикла',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Вероятность беременности - низкая',
                            style: textTheme.labelLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SectionContainer(
                    title: 'Мои циклы',
                    child: Row(
                      spacing: 2,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const .all(12),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerLow,
                              borderRadius: .horizontal(
                                left: const .circular(16),
                                right: const .circular(4),
                              ),
                            ),
                            child: Stack(
                              clipBehavior: .none,
                              children: [
                                Column(
                                  crossAxisAlignment: .start,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      'Средняя длительность месячных',
                                      style: textTheme.labelMedium?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Text(
                                      '5 дней',
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
                            padding: const .all(12),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerLow,
                              borderRadius: .horizontal(
                                right: const .circular(16),
                                left: const .circular(4),
                              ),
                            ),
                            child: Stack(
                              clipBehavior: .none,
                              children: [
                                Column(
                                  crossAxisAlignment: .start,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      'Средняя длительность цикла',
                                      style: textTheme.labelMedium?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Text(
                                      '28 дней',
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
