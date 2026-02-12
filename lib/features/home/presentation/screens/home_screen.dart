import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:periodility/core/common/widgets/block_container.dart';
import 'package:periodility/core/common/widgets/custom_list_tile.dart';
import 'package:periodility/core/common/widgets/icon_container.dart';
import 'package:periodility/core/common/widgets/section_container.dart';
import 'package:periodility/core/common/widgets/sliver_fill_overscroll.dart';
import 'package:periodility/core/common/widgets/tiles_column_view.dart';
import 'package:periodility/core/common/widgets/tiles_row_view.dart';
import 'package:periodility/core/common/widgets/tracker_app_bar.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/features/home/presentation/widgets/home_main_info.dart';
import 'package:periodility/features/home/presentation/widgets/invite_partner_banner.dart';
import 'package:sliver_header_parallax/sliver_header_parallax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late HeaderParallaxUtils _headerParallaxUtils;

  final double _minHeight = 0;
  final double _midHeightPercent = 0.4;
  final double _maxHeightPercent = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _headerParallaxUtils = HeaderParallaxUtils(
      context: context,
      mounted: mounted,
      minHeight: _minHeight,
      midHeightPercent: _midHeightPercent,
      maxHeightPercent: _maxHeightPercent,
      scrollController: _scrollController,
      excludeSize: kToolbarHeight + kBottomNavigationBarHeight,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _headerParallaxUtils.jumpToMidHeight();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    final double frictionPoint =
        _headerParallaxUtils.maxHeight - _headerParallaxUtils.midHeight;

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is UserScrollNotification) {
            _headerParallaxUtils.snapListener();
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: TensionScrollPhysics(
            frictionStartOffset: frictionPoint,
            tensionFactor: 0.5,
          ),
          slivers: [
            TrackerAppBar(
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

            SliverHeaderParallax(
              minHeight: _headerParallaxUtils.minHeight,
              midHeight: _headerParallaxUtils.midHeight,
              maxHeight: _headerParallaxUtils.maxHeight,
              child: const HomeMainInfo(),
            ),

            SliverToBoxAdapter(
              child: BlockContainer(
                child: _buildContent(textTheme, colorScheme),
              ),
            ),

            SliverFillOverscroll(
              child: Container(
                color: colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        SectionContainer(
          title: 'Фазы цикла',
          onPressed: () async {
            await context.push('/learn');
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
                          '/learn/${article.id}',
                          extra: {'label': article.title},
                        ),
                      );
                    })
                    .toList(),
              );
            },
          ),
        ),
        SectionContainer(
          title: 'Добавьте партнера',
          child: InvitePartnerBanner(
            onPressed: () {},
          ),
        ),
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
