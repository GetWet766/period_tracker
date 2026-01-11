import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';

abstract class CycleRepository {
  Future<Either<Failure, List<CycleLogEntity>>> getCycleLogs({
    DateTime? from,
    DateTime? to,
  });

  Future<Either<Failure, List<CycleLogEntity>>> getPartnerCycleLogs({
    required String partnerId,
    DateTime? from,
    DateTime? to,
  });

  Future<Either<Failure, CycleLogEntity?>> getCycleLogByDate(DateTime date);

  Future<Either<Failure, CycleLogEntity>> createCycleLog({
    required DateTime date,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  });

  Future<Either<Failure, CycleLogEntity>> updateCycleLog({
    required String id,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  });

  Future<Either<Failure, void>> deleteCycleLog(String id);
}
