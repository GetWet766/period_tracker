import 'package:dartz/dartz.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/core/services/cycle_service.dart';
import 'package:periodility/features/cycle/data/datasource/cycle_local_datasource.dart';
import 'package:periodility/features/cycle/data/models/cycle_model.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/domain/repositories/cycle_repository.dart';
import 'package:uuid/uuid.dart';

class CycleRepositoryImpl implements CycleRepository {
  const CycleRepositoryImpl({
    required CycleService cycleService,
    required CycleLocalDataSource localDataSource,
  }) : _cycleService = cycleService,
       _localDataSource = localDataSource;

  final CycleService _cycleService;
  final CycleLocalDataSource _localDataSource;
  // final CycleRemoteDataSource _remoteDataSource;

  @override
  Stream<Either<Failure, List<CycleEntity>>> getCycleHistory() async* {
    try {
      final localCycles = await _localDataSource.getAllCycles();
      yield Right(localCycles.map((cycle) => cycle.toEntity()).toList());
    } catch (e) {
      yield Left(CacheFailure(e.toString()));
    }

    // final remoteCycles = await _remoteDataSource.getAllCycles();
  }

  @override
  Future<Either<Failure, CycleEntity?>> getCurrentCycle() async {
    try {
      final localCycles = await _localDataSource.getLatestCycle();
      final entity = localCycles?.toEntity();
      if (entity != null) {
        final phase = _cycleService.getPhase(
          entity.startDate,
          entity,
          28,
        );
        final entityNew = entity.copyWith(
          avg: 28,
          daysTo: entity.startDate
              .add(const Duration(days: 28))
              .difference(DateTime.now())
              .inDays,
          phase: phase,
        );

        return Right(entityNew);
      }
      return Right(entity);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> startNewCycle(DateTime startDate) async {
    try {
      final newCycle = CycleModel(
        id: const Uuid().v4(),
        startDate: startDate,
        isManuallyStarted: true,
      ).toEntity();
      await _localDataSource.saveCycle(newCycle);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> finishCurrentCycle(DateTime endDate) async {
    try {
      final current = await _localDataSource.getLatestCycle();
      if (current != null && current.endDate == null) {
        // Проверяем, чтобы дата окончания не была раньше даты начала
        if (endDate.isBefore(current.startDate)) {
          return const Left(
            UnknownFailure("Date of end can't be before date of start!"),
          );
        }

        final updated = current.copyWith(endDate: endDate).toEntity();
        await _localDataSource.saveCycle(updated);
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCycle(CycleEntity cycle) async {
    try {
      await _localDataSource.saveCycle(cycle);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCycle(String id) async {
    try {
      await _localDataSource.deleteCycle(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
