import 'package:periodility/features/cycle/data/datasource/daily_logs_local_datasource.dart';
import 'package:periodility/features/cycle/data/models/daily_log_model.dart';
import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/repositories/daily_logs_repository.dart';

class DailyLogsRepositoryImpl implements DailyLogsRepository {
  const DailyLogsRepositoryImpl(this._dataSource);

  final DailyLogsLocalDataSource _dataSource;

  @override
  Future<DailyLogEntity?> getLogByDate(DateTime date) async {
    final model = await _dataSource.getLogByDate(date);
    return model?.toEntity();
  }

  @override
  Future<List<DailyLogEntity>> getLogsForRange(
    DateTime start,
    DateTime end,
  ) async {
    final models = await _dataSource.getLogsForRange(start, end);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveLog(DailyLogEntity log) {
    return _dataSource.saveDailyLog(
      DailyLogModel(
        id: log.id,
        date: log.date,
        userId: log.userId,
        symptoms: log.symptoms,
        mood: log.mood,
        notes: log.notes,
        flowLevels: log.flowLevels,
        updatedAt: DateTime.now(),
        // We might want to preserve createdAt if it exists, but Entity doesn't have it.
        // Assuming update or create logic in data source handles ID collision.
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> deleteLog(String id) {
    return _dataSource.deleteLog(id);
  }

  @override
  Stream<List<DailyLogEntity>> watchLogs() {
    return _dataSource.watchAllLogs().map(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }
}
