import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:period_tracker/features/cycle/domain/repositories/cycle_repository.dart';

class GetCycleLogsUseCase {
  GetCycleLogsUseCase(this._repository);

  final CycleRepository _repository;

  Future<Either<Failure, List<CycleLogEntity>>> call({
    DateTime? from,
    DateTime? to,
  }) => _repository.getCycleLogs(from: from, to: to);
}
