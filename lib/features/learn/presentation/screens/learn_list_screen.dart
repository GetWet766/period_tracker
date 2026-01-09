import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/features/learn/data/articles_data.dart';
import 'package:period_tracker/features/learn/presentation/widgets/article_card.dart';

class LearnListScreen extends StatelessWidget {
  const LearnListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const TrackerAppBar(
            title: Text('Информация'),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              margin: const .only(top: 16),
              padding: const .all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: .circular(28),
              ),
              child: SectionContainer(
                title: 'Фазы цикла',
                child: ClipRRect(
                  borderRadius: .circular(16),
                  child: Column(
                    spacing: 2,
                    children: cycleArticles.map((article) {
                      return ArticleCard(
                        article: article,
                        onTap: () => context.push(
                          '/learn/${article.id}',
                          extra: {'label': article.title},
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
