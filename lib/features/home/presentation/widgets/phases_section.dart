import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:periodility/core/common/widgets/custom_list_tile.dart';
import 'package:periodility/core/common/widgets/icon_container.dart';
import 'package:periodility/core/common/widgets/section_container.dart';
import 'package:periodility/core/common/widgets/tiles_column_view.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';

class PhasesSection extends StatelessWidget {
  const PhasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
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
    );
  }
}
