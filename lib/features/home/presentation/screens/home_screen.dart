import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:periodility/core/common/widgets/custom_list_tile.dart';
import 'package:periodility/core/common/widgets/icon_container.dart';
import 'package:periodility/core/common/widgets/section_container.dart';
import 'package:periodility/core/common/widgets/tiles_column_view.dart';
import 'package:periodility/core/common/widgets/tiles_row_view.dart';
import 'package:periodility/core/common/widgets/tracker_app_bar.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/features/home/presentation/widgets/home_main_info.dart';
import 'package:periodility/core/common/widgets/paralax_snap_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return Scaffold(
      body: ParallaxSnapSheet(
        sliverAppBar: TrackerAppBar(
          title: Text(
            DateFormat(
              'd MMMM',
              context.l10n.localeName,
            ).format(DateTime.now()),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
          actions: [
            IconButton.filled(
              onPressed: () => context.push('/profile'),
              icon: Icon(
                Symbols.person_rounded,
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        backgroundContent: const HomeMainInfo(),
        sheetContent: _buildContent(context, textTheme, colorScheme),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        SectionContainer(
          title: 'Фазы цикла',
          onPressed: () async {
            await context.push('/learn/phases?title=Фазы цикла');
          },
          child: BlocBuilder<ArticlesCubit, ArticlesState>(
            builder: (context, state) {
              return TilesColumnView(
                children: state.articles
                    .where(
                      (article) => article.categories.contains('phases'),
                    )
                    .map((article) {
                      return CustomListTile(
                        title: Text(article.title),
                        subtitle: Text(article.subtitle),
                        leading: IconContainer(
                          color: article.color,
                          icon: article.icon,
                        ),
                        trailing: const Icon(Symbols.arrow_right_rounded),
                        onPressed: () => context.push(
                          '/learn/${article.categories.first}/${article.id}',
                          extra: {'label': article.title},
                        ),
                      );
                    })
                    .toList(),
              );
            },
          ),
        ),
        // TODO: implement partner feature
        // SectionContainer(
        //   title: 'Добавьте партнера',
        //   child: InvitePartnerBanner(
        //     onPressed: () {},
        //   ),
        // ),
        SectionContainer(
          title: 'Мои циклы',
          child: TilesRowView(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: .circular(4),
                  ),
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              'Средняя длительность месячных',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            BlocSelector<CycleCubit, CycleState, CycleEntity?>(
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
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Icon(
                          Symbols.water_drop_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: .circular(4),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              'Средняя длительность цикла',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            BlocSelector<CycleCubit, CycleState, CycleEntity?>(
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
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Icon(
                          Symbols.sync_rounded,
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
    );
  }
}
