import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_symbols_icons/get.dart';
import 'package:periodility/core/utils/color_extension.dart';
import 'package:periodility/features/articles/domain/entities/article_entity.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
abstract class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required String id,
    required String title,
    required String subtitle,
    required String icon,
    required String color,
    required String contentURI,
    required List<String> categories,
  }) = _ArticleModel;

  const ArticleModel._();

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  ArticleEntity toEntity() {
    return ArticleEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      icon: SymbolsGet.get(icon, .rounded),
      color: color.toColor(),
      contentURI: contentURI,
      categories: categories,
    );
  }
}
