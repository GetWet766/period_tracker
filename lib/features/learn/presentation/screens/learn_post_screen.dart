import 'package:flutter/material.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/features/learn/data/articles_data.dart';

class LearnPostScreen extends StatelessWidget {
  const LearnPostScreen({required this.id, required this.label, super.key});

  final String id;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    final article = cycleArticles.firstWhere(
      (a) => a.id == id,
      orElse: () => cycleArticles.first,
    );

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const TrackerAppBar(
            title: Text('Справка'),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildHeader(context, article),
                const SizedBox(height: 16),
                _buildContent(context, article),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Article article) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
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
      ),
    );
  }

  Widget _buildContent(BuildContext context, Article article) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    final paragraphs = article.content.trim().split('\n\n');

    return Container(
      padding: const .all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: .circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: paragraphs.map((paragraph) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildParagraph(context, paragraph),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildParagraph(BuildContext context, String paragraph) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    // Check if it's a header (starts with ** and has closing **)
    if (paragraph.startsWith('**')) {
      // Find the closing **
      final closingIndex = paragraph.indexOf('**', 2);
      if (closingIndex > 2) {
        final header = paragraph.substring(2, closingIndex).replaceAll(':', '');
        final content = paragraph.substring(closingIndex + 2).trim();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            if (content.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildTextContent(context, content),
            ],
          ],
        );
      }
    }

    return _buildTextContent(context, paragraph);
  }

  Widget _buildTextContent(BuildContext context, String content) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    final lines = content.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.startsWith('• ')) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    line.substring(2),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            line,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        );
      }).toList(),
    );
  }
}
