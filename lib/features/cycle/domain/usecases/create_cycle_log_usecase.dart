import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:period_tracker/features/cycle/domain/repositories/cycle_repository.dart';

class CreateCycleLogUseCase {
  CreateCycleLogUseCase(this._repository);

  final CycleRepository _repository;

  Future<Either<Failure, CycleLogEntity>> call({
    required DateTime date,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  }) => _repository.createCycleLog(
    date: date,
    flowLevel: flowLevel,
    symptoms: symptoms,
    notes: notes,
  );
}
