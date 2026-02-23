import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:periodility/core/common/widgets/section_container.dart';
import 'package:periodility/core/common/widgets/tiles_row_view.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/features/home/presentation/widgets/my_cycles_tile.dart';

class MyCycles extends StatelessWidget {
  const MyCycles({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return SectionContainer(
      title: 'Мои циклы',
      child: TilesRowView(
        children: [
          MyCyclesTile(
            title: 'Средняя длительность месячных',
            value: BlocSelector<CycleCubit, CycleState, CycleEntity?>(
              selector: (state) => state.currentCycle,
              builder: (context, state) {
                // Default to 5 days for now
                const avgPeriod = 5;
                return Text(
                  '$avgPeriod дней',
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                );
              },
            ),
            icon: Symbols.water_drop_rounded,
          ),
          MyCyclesTile(
            title: 'Средняя длительность цикла',
            value: BlocSelector<CycleCubit, CycleState, CycleEntity?>(
              selector: (state) => state.currentCycle,
              builder: (context, state) {
                final avgCycle = state?.avg ?? 28;
                return Text(
                  '$avgCycle дней',
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                );
              },
            ),
            icon: Symbols.sync_rounded,
          ),
        ],
      ),
    );
  }
}
