import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:periodility/core/common/widgets/block_container.dart';
import 'package:periodility/core/common/widgets/sliver_fill_overscroll.dart';
import 'package:periodility/core/common/widgets/tracker_app_bar.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';

class LearnPostScreen extends StatefulWidget {
  const LearnPostScreen({required this.id, super.key});

  final String id;

  @override
  State<LearnPostScreen> createState() => _LearnPostScreenState();
}

class _LearnPostScreenState extends State<LearnPostScreen> {
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

    return Container(
      margin: const .only(top: 16, bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: BlocBuilder<ArticlesCubit, ArticlesState>(
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

          return Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: article.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  article.icon,
                  color: article.color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.subtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlockContainer(
      child: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          final article = state.currentArticle;

          if (article == null) {
            return const Text('Something wrong!');
          }

          return MarkdownBody(
            data: article.content,
          );
        },
      ),
    );
  }
}
