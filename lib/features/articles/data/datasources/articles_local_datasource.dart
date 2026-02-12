import 'dart:convert';

import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/services.dart';
import 'package:periodility/core/constants/articles.dart';
import 'package:periodility/core/errors/exceptions.dart';
import 'package:periodility/features/articles/data/models/article_model.dart';

abstract class ArticlesLocalDataSource {
  Future<List<String>> getCategories();
  Future<List<ArticleModel>> getArticles({String? category});
  Future<ArticleModel> getArticle({required String id});
  Future<String> getArticleContent({required String contentUri});
}

class ArticlesLocalDataSourceImpl implements ArticlesLocalDataSource {
  @override
  Future<List<ArticleModel>> getArticles({String? category}) async {
    final response = await rootBundle.loadString(
      ArticlesConstants.articlesLocalFile,
    );
    final json = jsonDecode(response) as Map<String, dynamic>;
    final articles = json['articles'] as List<dynamic>;

    final result =
        articles
            .map((el) => ArticleModel.fromJson(el as Map<String, dynamic>))
            .toList()
          ..removeWhere(
            (element) =>
                !(category == null || category.isEmpty) &&
                !element.categories.contains(category),
          );

    return result;
  }

  @override
  Future<ArticleModel> getArticle({required String id}) async {
    final response = await getArticles();
    final result = response.findFirst(
      (element) => element.id == id,
    );

    if (result == null) {
      throw const CacheException('Article not found!');
    }

    return result;
  }

  @override
  Future<String> getArticleContent({required String contentUri}) async {
    final response = await rootBundle.loadString(contentUri);

    return response;
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await rootBundle.loadString(
      ArticlesConstants.articlesLocalFile,
    );
    final json = jsonDecode(response) as Map<String, dynamic>;
    final categories = json['categories'] as List<dynamic>;

    return List<String>.from(categories);
  }
}
