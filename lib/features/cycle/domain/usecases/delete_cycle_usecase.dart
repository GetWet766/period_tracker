import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/cycle/domain/repositories/cycle_repository.dart';

class DeleteCycleUseCase {
  const DeleteCycleUseCase(this._repository);

  final CycleRepository _repository;
  Future<Either<Failure, void>> call({required String id}) async =>
      _repository.deleteCycle(id);
}
