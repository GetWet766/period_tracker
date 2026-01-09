import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/features/calendar/presentation/widgets/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();

  bool get isSelectedToday => DateUtils.isSameDay(selectedDay, DateTime.now());

  final periodConfig = PeriodConfig(
    lastPeriodStart: DateTime.now(),
  );
  DayInfo? get dayInfo => periodConfig.getSelectedDayInfo(selectedDay);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const TrackerAppBar(
            title: Text('Календарь'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const .all(16),
              child: Calendar(
                periodConfig: periodConfig,
                selectedDay: selectedDay,
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
              padding: const .all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const .vertical(top: .circular(28)),
              ),
              child: Column(
                crossAxisAlignment: .stretch,
                spacing: 16,
                children: [
                  SectionContainer(
                    title:
                        '${isSelectedToday ? 'Сегодня: ' : ''}${DateFormat('d MMMM').format(selectedDay)}',
                    child: Container(
                      clipBehavior: .antiAlias,
                      decoration: BoxDecoration(borderRadius: .circular(16)),
                      child: Column(
                        spacing: 2,
                        children: dayInfo != null
                            ? dayInfo!.toDisplayList().map(
                                (e) {
                                  return Material(
                                    type: .transparency,
                                    child: InkWell(
                                      borderRadius: .circular(4),
                                      onTap: () => context.push(
                                        '/learn/${e.id}',
                                        extra: {'label': e.label},
                                      ),
                                      child: Ink(
                                        padding: const .symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: .circular(4),
                                          color:
                                              colorScheme.surfaceContainerLow,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: .start,
                                                children: [
                                                  Text(
                                                    e.label,
                                                    style: textTheme.bodyLarge
                                                        ?.copyWith(
                                                          color: colorScheme
                                                              .onSurfaceVariant,
                                                        ),
                                                  ),
                                                  Text(
                                                    e.value,
                                                    style: textTheme.bodyMedium
                                                        ?.copyWith(
                                                          color: colorScheme
                                                              .onSurfaceVariant,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const HugeIcon(
                                              icon: HugeIcons
                                                  .strokeRoundedArrowRight01,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList()
                            : [
                                Container(
                                  padding: const .symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: .circular(4),
                                    color: colorScheme.surfaceContainerLow,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: .start,
                                          children: [
                                            Text(
                                              'Нет информации',
                                              style: textTheme.bodyLarge
                                                  ?.copyWith(
                                                    color: colorScheme
                                                        .onSurfaceVariant,
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
