import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/cycle/domain/repositories/cycle_repository.dart';

class DeleteCycleLogUseCase {
  DeleteCycleLogUseCase(this._repository);

  final CycleRepository _repository;

  Future<Either<Failure, void>> call(String id) =>
      _repository.deleteCycleLog(id);
}
