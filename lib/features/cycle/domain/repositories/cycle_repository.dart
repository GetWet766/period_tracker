import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';

abstract class CycleRepository {
  Stream<Either<Failure, List<CycleEntity>>> getCycleHistory();
  Future<Either<Failure, CycleEntity?>> getCurrentCycle();
  Future<Either<Failure, void>> startNewCycle(DateTime startDate);
  Future<Either<Failure, void>> finishCurrentCycle(DateTime endDate);
  Future<Either<Failure, void>> updateCycle(CycleEntity cycle);
  Future<Either<Failure, void>> deleteCycle(String id);
}
