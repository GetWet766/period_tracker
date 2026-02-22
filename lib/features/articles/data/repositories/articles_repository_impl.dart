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
      final articles = articlesModel
          .map((el) => _withImage(el.toEntity()))
          .toList();
      return Right(articles);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  ArticleEntity _withImage(ArticleEntity article) {
    String? imageUrl;
    switch (article.id) {
      case 'nutrition-phases':
      case 'vitamins':
        imageUrl = 'assets/images/nutrition_bg.png';
      case 'hygiene':
        imageUrl = 'assets/images/hygiene_bg.png';
      case 'menstruation':
      case 'follicular':
      case 'ovulation':
      case 'luteal':
        imageUrl = 'assets/images/care_bg.png';
      default:
        imageUrl = null;
    }
    return article.copyWith(imageUrl: imageUrl);
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
      final articleEntity = _withImage(articleModel.toEntity()).copyWith(
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
