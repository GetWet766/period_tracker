import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class HomeMainInfo extends StatelessWidget {
  const HomeMainInfo({
    required this.isPeriodActive,
    this.currentPeriodDay,
    this.daysUntilPeriod,
    super.key,
  });

  final bool isPeriodActive;
  final int? currentPeriodDay;
  final int? daysUntilPeriod;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 16,
      ),
      child: Column(
        children: [
          Text(
            isPeriodActive
                ? 'День менструации:'
                : 'До начала менструации осталось:',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isPeriodActive
                ? '$currentPeriodDay день'
                : getDays(daysUntilPeriod!),
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
            onPressed: () {
              // _togglePeriod(cycleInfo);
            },
            label: Text(
              isPeriodActive ? 'Закончились' : 'Начались',
            ),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedGiveBlood,
            ),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () {
              //  _showSymptomsDialog(context);
            },
            child: const Text(
              // TODO: "Редактировать сегодняшнее самочувствие"
              'Как Вы себя чувствуете сегодня?',
            ),
          ),
          // if (symptoms.length > 0)
          // symptoms.map((el) => SymptomCard(name: el.name, value: el.value, isSelected: el.isSelected))
          Wrap(
            alignment: .center,
            spacing: 8,
            children: [
              FilterChip(
                shape: RoundedRectangleBorder(borderRadius: .circular(9999)),
                label: const Text('Липкие'),
                selected: true,
                onSelected: (value) {},
              ),
              FilterChip(
                shape: RoundedRectangleBorder(borderRadius: .circular(9999)),
                label: const Text('Обильные'),
                onSelected: (value) {},
              ),
              FilterChip(
                shape: RoundedRectangleBorder(borderRadius: .circular(9999)),
                label: const Text('Болезненные'),
                selected: true,
                onSelected: (value) {},
              ),
            ],
          ),
        ],
      ),
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
}
