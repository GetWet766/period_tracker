import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/articles/domain/entities/article_entity.dart';

abstract class ArticlesRepository {
  Future<Either<Failure, List<ArticleEntity>>> getArticles({
    String? category,
  });

  Future<Either<Failure, ArticleEntity?>> getArticle({
    required String id,
  });
  Future<Either<Failure, List<String>>> getCategories();
}
