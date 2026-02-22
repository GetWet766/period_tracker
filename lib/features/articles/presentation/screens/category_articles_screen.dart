import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:periodility/core/common/widgets/section_container.dart';
import 'package:periodility/core/common/widgets/sliver_fill_overscroll.dart';
import 'package:periodility/core/common/widgets/tiles_column_view.dart';
import 'package:periodility/core/common/widgets/tracker_app_bar.dart';
import 'package:periodility/core/utils/locale_extension.dart';
import 'package:periodility/features/articles/domain/entities/article_entity.dart';
import 'package:periodility/features/articles/presentation/cubit/article_categories_cubit.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:periodility/features/articles/presentation/widgets/article_tile.dart';

class CategoryArticlesScreen extends StatefulWidget {
  const CategoryArticlesScreen({
    required this.id,
    required this.title,
    super.key,
  });
  final String id;
  final String title;

  @override
  State<CategoryArticlesScreen> createState() => _CategoryArticlesScreenState();
}

class _CategoryArticlesScreenState extends State<CategoryArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          TrackerAppBar(
            title: Text(widget.title),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async => context.read<ArticlesCubit>().getArticles(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  height: 20,
                ),
              ),
              BlocSelector<
                ArticleCategoriesCubit,
                ArticleCategoriesState,
                List<String>
              >(
                selector: (state) {
                  return state.categories;
                },
                builder: (context, categoriesState) {
                  return BlocSelector<
                    ArticlesCubit,
                    ArticlesState,
                    List<ArticleEntity>
                  >(
                    selector: (state) {
                      return state.articles;
                    },
                    builder: (context, state) {
                      final categories = categoriesState
                          .where(
                            (category) => category.contains(widget.id),
                          )
                          .toList();

                      return SliverList.separated(
                        itemCount: categories.length,
                        separatorBuilder: (context, index) =>
                            Container(color: colorScheme.surface, height: 16),
                        itemBuilder: (context, index) {
                          final section = categories[index];
                          final sectionArticles = state
                              .where((e) => e.categories.contains(section))
                              .toList();

                          return Container(
                            color: colorScheme.surface,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SectionContainer(
                              title: context.l10n.articleCategory(section),
                              child: TilesColumnView(
                                children: sectionArticles
                                    .map(
                                      (article) => ArticleTile(
                                        article: article,
                                        onTap: () => context.push(
                                          '/learn/${article.categories.first}/${article.id}',
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              SliverFillOverscroll(
                child: Container(
                  height: 16 + context.paddingBottom,
                  color: colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
