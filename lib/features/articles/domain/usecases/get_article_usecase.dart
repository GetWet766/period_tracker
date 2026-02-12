import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/articles/domain/entities/article_entity.dart';
import 'package:periodility/features/articles/domain/repositories/articles_repository.dart';

class GetArticleUseCase {
  const GetArticleUseCase(this._repository);

  final ArticlesRepository _repository;
  Future<Either<Failure, ArticleEntity?>> call({required String id}) async =>
      _repository.getArticle(id: id);
}
