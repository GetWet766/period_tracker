import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/cycle/data/datasource/cycle_local_datasource.dart';
import 'package:period_tracker/features/cycle/data/datasource/cycle_remote_datasource.dart';
import 'package:period_tracker/features/cycle/data/models/cycle_log_model.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:period_tracker/features/cycle/domain/repositories/cycle_repository.dart';

class CycleRepositoryImpl implements CycleRepository {
  CycleRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final CycleRemoteDataSource _remoteDataSource;
  final CycleLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<CycleLogEntity>>> getCycleLogs({
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      // Try remote first
      final logs = await _remoteDataSource.getCycleLogs(from: from, to: to);
      // Cache locally
      await _localDataSource.saveCycleLogs(logs);
      return Right(logs.map((e) => e.toEntity()).toList());
    } on Exception {
      // Fallback to local
      try {
        final localLogs = _localDataSource.getCycleLogs();
        var filtered = localLogs;

        if (from != null) {
          filtered = filtered.where((e) => !e.date.isBefore(from)).toList();
        }
        if (to != null) {
          filtered = filtered.where((e) => !e.date.isAfter(to)).toList();
        }

        return Right(filtered.map((e) => e.toEntity()).toList());
      } on Exception catch (e) {
        return Left(ServerFailure('Ошибка получения логов: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, List<CycleLogEntity>>> getPartnerCycleLogs({
    required String partnerId,
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final logs = await _remoteDataSource.getPartnerCycleLogs(
        partnerId: partnerId,
        from: from,
        to: to,
      );
      return Right(logs.map((e) => e.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ServerFailure('Ошибка получения логов партнёра: $e'));
    }
  }

  @override
  Future<Either<Failure, CycleLogEntity?>> getCycleLogByDate(
    DateTime date,
  ) async {
    try {
      final log = await _remoteDataSource.getCycleLogByDate(date);
      return Right(log?.toEntity());
    } on Exception {
      // Fallback to local
      try {
        final localLogs = _localDataSource.getCycleLogs();
        final normalizedDate = DateTime(date.year, date.month, date.day);
        final log = localLogs.where((e) {
          final logDate = DateTime(e.date.year, e.date.month, e.date.day);
          return logDate == normalizedDate;
        }).firstOrNull;
        return Right(log?.toEntity());
      } on Exception catch (e) {
        return Left(ServerFailure('Ошибка получения лога: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, CycleLogEntity>> createCycleLog({
    required DateTime date,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  }) async {
    try {
      final log = await _remoteDataSource.createCycleLog(
        date: date,
        flowLevel: flowLevel,
        symptoms: symptoms,
        notes: notes,
      );
      // Cache locally
      await _localDataSource.addCycleLog(log);
      return Right(log.toEntity());
    } on Exception {
      // Create locally for offline mode
      try {
        final localLog = _createLocalLog(
          date: date,
          flowLevel: flowLevel,
          symptoms: symptoms,
          notes: notes,
        );
        await _localDataSource.addCycleLog(localLog);
        return Right(localLog.toEntity());
      } on Exception catch (e) {
        return Left(ServerFailure('Ошибка создания лога: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, CycleLogEntity>> updateCycleLog({
    required String id,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  }) async {
    try {
      final log = await _remoteDataSource.updateCycleLog(
        id: id,
        flowLevel: flowLevel,
        symptoms: symptoms,
        notes: notes,
      );
      // Update local cache
      await _localDataSource.updateCycleLog(log);
      return Right(log.toEntity());
    } on Exception {
      // Update locally for offline mode
      try {
        final localLogs = _localDataSource.getCycleLogs();
        final existingLog = localLogs.firstWhere((e) => e.id == id);
        final updatedLog = existingLog.copyWith(
          flowLevel: flowLevel?.name ?? existingLog.flowLevel,
          symptoms: symptoms ?? existingLog.symptoms,
          notes: notes ?? existingLog.notes,
        );
        await _localDataSource.updateCycleLog(updatedLog);
        return Right(updatedLog.toEntity());
      } on Exception catch (e) {
        return Left(ServerFailure('Ошибка обновления лога: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteCycleLog(String id) async {
    try {
      await _remoteDataSource.deleteCycleLog(id);
      // Remove from local cache
      await _localDataSource.deleteCycleLog(id);
      return const Right(null);
    } on Exception {
      // Delete locally for offline mode
      try {
        await _localDataSource.deleteCycleLog(id);
        return const Right(null);
      } on Exception catch (e) {
        return Left(ServerFailure('Ошибка удаления лога: $e'));
      }
    }
  }

  CycleLogModel _createLocalLog({
    required DateTime date,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  }) {
    return CycleLogModel(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'guest',
      date: date,
      flowLevel: flowLevel?.name,
      symptoms: symptoms,
      notes: notes,
      createdAt: DateTime.now(),
    );
  }
}
