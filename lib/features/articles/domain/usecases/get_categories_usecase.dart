import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/articles/domain/repositories/articles_repository.dart';

class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final ArticlesRepository _repository;
  Future<Either<Failure, List<String>>> call() async =>
      _repository.getCategories();
}
