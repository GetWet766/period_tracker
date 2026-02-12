import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/cycle/domain/repositories/cycle_repository.dart';

class FinishCurrentCycleUseCase {
  const FinishCurrentCycleUseCase(this._repository);

  final CycleRepository _repository;
  Future<Either<Failure, void>> call({required DateTime endDate}) async =>
      _repository.finishCurrentCycle(endDate);
}
