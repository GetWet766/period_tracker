import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:periodility/core/common/widgets/custom_list_tile.dart';
import 'package:periodility/core/common/widgets/icon_container.dart';
import 'package:periodility/core/common/widgets/section_container.dart';
import 'package:periodility/core/common/widgets/tiles_column_view.dart';
import 'package:periodility/core/common/widgets/tracker_app_bar.dart';
import 'package:periodility/features/articles/domain/entities/article_entity.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:periodility/core/common/widgets/paralax_snap_sheet.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParallaxSnapSheet(
        radius: 0,
        sliverAppBar: const TrackerAppBar(title: Text('Уход')),
        backgroundContent: _buildBackground(context),
        sheetContent: _buildSheetContent(context),
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/care_bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorScheme.surface.withValues(alpha: 0.4),
                  colorScheme.surface.withValues(alpha: 0.8),
                  colorScheme.surface,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Совет дня',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Пейте больше воды во время лютеиновой фазы для уменьшения отечности.',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSheetContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionContainer(
          title: 'Индивидуальный уход',
          child: TilesColumnView(
            children: [
              CustomListTile(
                title: Text('Питание и диета'),
                subtitle: Text('Рекомендации по рациону в вашей фазе'),
                leading: IconContainer(
                  icon: Symbols.nutrition_rounded,
                  color: Colors.orange,
                ),
              ),
              CustomListTile(
                title: Text('Кожа и волосы'),
                subtitle: Text('Особенности ухода за собой сегодня'),
                leading: IconContainer(
                  icon: Symbols.face_6_rounded,
                  color: Colors.pinkAccent,
                ),
              ),
              CustomListTile(
                title: Text('Физическая нагрузка'),
                subtitle: Text('Какая активность будет наиболее полезной'),
                leading: IconContainer(
                  icon: Symbols.exercise_rounded,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionContainer(
          title: 'Чек-лист на сегодня',
          child: TilesColumnView(
            children: [
              CustomListTile(
                title: const Text('Утренняя медитация (10 мин)'),
                leading: SizedBox(
                  width: 32,
                  height: 32,
                  child: Checkbox(value: true, onChanged: (value) {}),
                ),
              ),
              CustomListTile(
                title: const Text('Контрастный душ'),
                leading: SizedBox(
                  width: 32,
                  height: 32,
                  child: Checkbox(value: true, onChanged: (value) {}),
                ),
              ),
              CustomListTile(
                title: const Text('Прием витамина D'),
                leading: SizedBox(
                  width: 32,
                  height: 32,
                  child: Checkbox(value: true, onChanged: (value) {}),
                ),
              ),
              CustomListTile(
                title: const Text('Прогулка на свежем воздухе'),
                leading: SizedBox(
                  width: 32,
                  height: 32,
                  child: Checkbox(value: true, onChanged: (value) {}),
                ),
              ),
              CustomListTile(
                title: const Text('Прием витамина D'),
                leading: SizedBox(
                  width: 32,
                  height: 32,
                  child: Checkbox(value: true, onChanged: (value) {}),
                ),
              ),
              CustomListTile(
                title: const Text('Прогулка на свежем воздухе'),
                leading: SizedBox(
                  width: 32,
                  height: 32,
                  child: Checkbox(value: true, onChanged: (value) {}),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionContainer(
          title: 'Полезные статьи',
          onPressed: () => context.push('/learn'),
          child: BlocBuilder<ArticlesCubit, ArticlesState>(
            builder: (context, state) {
              final articles = state.articles.take(5).toList();
              if (articles.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 160,
                child: CarouselView.weighted(
                  itemSnapping: true,
                  flexWeights: const <int>[2, 1],
                  shape: RoundedRectangleBorder(borderRadius: .circular(16)),
                  children: List<Widget>.generate(articles.length, (index) {
                    return _buildArticleCard(context, articles[index]);
                  }),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildArticleCard(BuildContext context, ArticleEntity article) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Hero(
      key: ValueKey('care_screen_hero_${article.id}'),
      tag: 'article_image_${article.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              context.push('/learn/${article.categories.first}/${article.id}'),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: article.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              image: article.imageUrl != null
                  ? DecorationImage(
                      image: AssetImage(article.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                mainAxisAlignment: .end,
                children: [
                  if (article.imageUrl == null)
                    Icon(
                      article.icon,
                      color: article.color,
                      size: 32,
                    ),
                  if (article.imageUrl == null) const Spacer(),
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      color: article.imageUrl != null
                          ? Colors.white
                          : colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall?.copyWith(
                      color: article.imageUrl != null
                          ? Colors.white70
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
