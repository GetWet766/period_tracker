import 'package:periodility/features/cycle/data/datasource/daily_logs_local_datasource.dart';
import 'package:periodility/features/cycle/data/models/daily_log_model.dart';
import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/repositories/daily_logs_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DailyLogsRepositoryImpl implements DailyLogsRepository {
  const DailyLogsRepositoryImpl(this._dataSource, this._talker);

  final DailyLogsLocalDataSource _dataSource;
  final Talker _talker;

  @override
  Future<DailyLogEntity?> getLogByDate(DateTime date) async {
    try {
      final model = await _dataSource.getLogByDate(date);
      return model?.toEntity();
    } catch (e, st) {
      _talker.handle(e, st, 'DailyLogsRepository: getLogByDate error');
      rethrow;
    }
  }

  @override
  Future<List<DailyLogEntity>> getLogsForRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final models = await _dataSource.getLogsForRange(start, end);
      return models.map((e) => e.toEntity()).toList();
    } catch (e, st) {
      _talker.handle(e, st, 'DailyLogsRepository: getLogsForRange error');
      rethrow;
    }
  }

  @override
  Future<void> saveLog(DailyLogEntity log) async {
    try {
      await _dataSource.saveDailyLog(
        DailyLogModel(
          id: log.id,
          date: log.date,
          userId: log.userId,
          symptoms: log.symptoms,
          mood: log.mood,
          notes: log.notes,
          flowLevels: log.flowLevels,
          updatedAt: DateTime.now(),
          createdAt: DateTime.now(),
        ),
      );
    } catch (e, st) {
      _talker.handle(e, st, 'DailyLogsRepository: saveLog error');
      rethrow;
    }
  }

  @override
  Future<void> deleteLog(String id) async {
    try {
      await _dataSource.deleteLog(id);
    } catch (e, st) {
      _talker.handle(e, st, 'DailyLogsRepository: deleteLog error');
      rethrow;
    }
  }

  @override
  Stream<List<DailyLogEntity>> watchLogs() {
    return _dataSource
        .watchAllLogs()
        .map(
          (models) => models.map((e) => e.toEntity()).toList(),
        )
        .handleError((Object e, StackTrace st) {
          _talker.handle(e, st, 'DailyLogsRepository: watchLogs error');
        });
  }
}
