import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:periodility/core/common/widgets/custom_list_tile.dart';
import 'package:periodility/core/common/widgets/icon_container.dart';
import 'package:periodility/features/articles/domain/entities/article_entity.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    required this.article,
    required this.onTap,
    super.key,
  });

  final ArticleEntity article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: Text(article.title),
      subtitle: Text(article.subtitle),
      leading: IconContainer(
        color: article.color,
        icon: article.icon,
      ),
      trailing: const Icon(Symbols.arrow_right_rounded),
      onPressed: onTap,
    );
  }
}
