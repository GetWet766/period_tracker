import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/domain/repositories/cycle_repository.dart';

class GetCycleHistoryUseCase {
  const GetCycleHistoryUseCase(this._repository);

  final CycleRepository _repository;
  Stream<Either<Failure, List<CycleEntity>>> call() =>
      _repository.getCycleHistory();
}
