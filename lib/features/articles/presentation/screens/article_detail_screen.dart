import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:periodility/core/common/widgets/block_container.dart';
import 'package:periodility/core/common/widgets/sliver_fill_overscroll.dart';
import 'package:periodility/core/common/widgets/tracker_app_bar.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({required this.id, super.key});

  final String id;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArticlesCubit>().getArticle(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const TrackerAppBar(
            title: Text('Справка'),
          ),
          SliverToBoxAdapter(
            child: _buildHeader(context),
          ),

          SliverToBoxAdapter(
            child: _buildContent(context),
          ),
          SliverFillOverscroll(
            child: Container(
              height: 16 + context.paddingBottom,
              color: colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return BlocBuilder<ArticlesCubit, ArticlesState>(
      builder: (context, state) {
        final isLoading = state.isLoading;
        final article = state.currentArticle;

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (article == null) {
          return const Text('Something went wrong!');
        }

        return Hero(
          tag: 'article_image_${article.id}',
          child: Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            height: 200,
            decoration: BoxDecoration(
              // color: article.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(28),
              image: article.imageUrl != null
                  ? DecorationImage(
                      image: AssetImage(article.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // begin: .center,
                  begin: const AlignmentGeometry.directional(0, -0.5),
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (article.imageUrl == null)
                    Icon(
                      article.icon,
                      color: article.color,
                      size: 48,
                    ),
                  if (article.imageUrl == null) const Spacer(),
                  Text(
                    article.title,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: article.imageUrl != null
                          ? Colors.white
                          : colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: article.imageUrl != null
                          ? Colors.white70
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return BlockContainer(
      child: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          final article = state.currentArticle;

          if (article == null) {
            if (state.isLoading) return const SizedBox.shrink();
            return const Text('Something wrong!');
          }

          return MarkdownBody(
            styleSheet: MarkdownStyleSheet(
              h1: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              h2: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              h3: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              h4: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              h5: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              h6: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
            data: article.content,
          );
        },
      ),
    );
  }
}
