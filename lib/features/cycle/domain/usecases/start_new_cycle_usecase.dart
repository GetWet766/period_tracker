import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/cycle/domain/repositories/cycle_repository.dart';

class StartNewCycleUseCase {
  const StartNewCycleUseCase(this._repository);

  final CycleRepository _repository;
  Future<Either<Failure, void>> call({required DateTime startDate}) async =>
      _repository.startNewCycle(startDate);
}
