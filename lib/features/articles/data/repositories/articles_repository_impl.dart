import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/articles/data/datasources/articles_local_datasource.dart';
import 'package:periodility/features/articles/domain/entities/article_entity.dart';
import 'package:periodility/features/articles/domain/repositories/articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRepositoryImpl(this._localDataSource);

  final ArticlesLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles({
    String? category,
  }) async {
    try {
      final articlesModel = await _localDataSource.getArticles();
      final articles = articlesModel.map((el) => el.toEntity()).toList();
      return Right(articles);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ArticleEntity?>> getArticle({
    required String id,
  }) async {
    try {
      final articleModel = await _localDataSource.getArticle(id: id);
      final articleContent = await _localDataSource.getArticleContent(
        contentUri: articleModel.contentURI,
      );
      final articleEntity = articleModel.toEntity().copyWith(
        content: articleContent,
      );
      return Right(articleEntity);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await _localDataSource.getCategories();

      return Right(categories);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
