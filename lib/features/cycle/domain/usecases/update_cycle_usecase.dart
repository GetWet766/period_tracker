import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/domain/repositories/cycle_repository.dart';

class UpdateCycleUseCase {
  const UpdateCycleUseCase(this._repository);

  final CycleRepository _repository;
  Future<Either<Failure, void>> call({required CycleEntity cycle}) async =>
      _repository.updateCycle(cycle);
}
