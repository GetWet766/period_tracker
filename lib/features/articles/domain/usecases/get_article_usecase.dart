import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/errors.dart';
import 'package:periodility/features/articles/domain/domain.dart';

class GetArticleUseCase {
  const GetArticleUseCase(this._repository);

  final ArticlesRepository _repository;
  Future<Either<Failure, ArticleEntity?>> call({required String id}) async =>
      _repository.getArticle(id: id);
}
