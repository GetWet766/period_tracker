import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';

class HomeMainInfo extends StatefulWidget {
  const HomeMainInfo({super.key});

  @override
  State<HomeMainInfo> createState() => _HomeMainInfoState();
}

class _HomeMainInfoState extends State<HomeMainInfo> {
  bool isDailyExists = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return BlocSelector<CycleCubit, CycleState, CycleEntity?>(
      selector: (state) => state.currentCycle,
      builder: (context, state) {
        final hasCurrentCycle = state != null;
        // If endDate is null, it means menstruation is currently active
        // (based on our logic that endDate marks end of period)
        // OR it means cycle is ongoing?
        // Logic in CycleCalculator: periodLength = endDate - startDate.
        // So endDate marks end of menstruation.
        // So if endDate is null -> Menstruation is active.
        final isPeriodActive = hasCurrentCycle && state.endDate == null;

        final daysTo = state?.daysTo ?? 0;

        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 16,
          ),
          child: Column(
            mainAxisSize: .min,
            children: [
              Text(
                hasCurrentCycle
                    ? context.l10n.until_period(
                        num.tryParse(daysTo.toString()) ?? 0,
                      )
                    : 'Нет информации',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                hasCurrentCycle
                    ? context.l10n.days_until_period(
                        num.tryParse(daysTo.toString()) ?? 0,
                      )
                    : 'Нет информации',
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
              if (!isDailyExists)
                FilledButton(
                  onPressed: () {
                    //  _showSymptomsDialog(context);
                  },
                  child: const Text(
                    // TODO(mihail): "Редактировать сегодняшнее самочувствие"
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
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(9999),
                    ),
                    label: const Text('Липкие'),
                    selected: true,
                    onSelected: (value) {
                      setState(() {
                        isDailyExists = true;
                      });
                    },
                  ),
                  FilterChip(
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(9999),
                    ),
                    label: const Text('Обильные'),
                    onSelected: (value) {
                      setState(() {
                        isDailyExists = false;
                      });
                    },
                  ),
                  FilterChip(
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(9999),
                    ),
                    label: const Text('Болезненные'),
                    selected: true,
                    onSelected: (value) {},
                  ),
                ],
              ),
            ],
          ),
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
