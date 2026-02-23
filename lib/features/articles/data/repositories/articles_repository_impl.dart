import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/errors.dart';
import 'package:periodility/features/articles/data/data.dart';
import 'package:periodility/features/articles/domain/domain.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRepositoryImpl(this._localDataSource, this._talker);

  final ArticlesLocalDataSource _localDataSource;
  final Talker _talker;

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
    } catch (e, st) {
      _talker.handle(e, st, 'ArticlesRepository: getArticles error');
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
    } catch (e, st) {
      _talker.handle(e, st, 'ArticlesRepository: getArticle error ($id)');
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await _localDataSource.getCategories();
      return Right(categories);
    } catch (e, st) {
      _talker.handle(e, st, 'ArticlesRepository: getCategories error');
      return Left(CacheFailure(e.toString()));
    }
  }
}
