import 'package:isar_plus/isar_plus.dart';
import 'package:periodility/core/utils/fast_hash_extension.dart';
import 'package:periodility/features/cycle/data/models/daily_log_model.dart';

abstract class DailyLogsLocalDataSource {
  Future<void> saveDailyLog(DailyLogModel log);
  Future<DailyLogModel?> getLogByDate(DateTime date);
  Future<List<DailyLogModel>> getLogsForMonth(int year, int month);
  Future<List<DailyLogModel>> getLogsForRange(DateTime start, DateTime end);
  Stream<List<DailyLogModel>> watchAllLogs();
  Future<bool> deleteLog(String uuid);
}

class DailyLogsLocalDataSourceImpl implements DailyLogsLocalDataSource {
  const DailyLogsLocalDataSourceImpl(this._client);

  final Isar _client;

  @override
  Future<void> saveDailyLog(DailyLogModel log) async {
    await _client.writeAsync(
      (isar) {
        isar.dailyLogModels.put(log);
      },
    );
  }

  @override
  Future<DailyLogModel?> getLogByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return _client.dailyLogModels
        .where()
        .dateBetween(startOfDay, endOfDay)
        .findFirst();
  }

  @override
  Future<List<DailyLogModel>> getLogsForMonth(int year, int month) async {
    final startOfMonth = DateTime(year, month);
    final endOfMonth = DateTime(year, month + 1, 0, 23, 59, 59);

    return _client.dailyLogModels
        .where()
        .dateBetween(startOfMonth, endOfMonth)
        .sortByDate()
        .findAll();
  }

  @override
  Future<List<DailyLogModel>> getLogsForRange(
    DateTime start,
    DateTime end,
  ) async {
    return _client.dailyLogModels
        .where()
        .dateBetween(start, end)
        .sortByDate()
        .findAll();
  }

  @override
  Stream<List<DailyLogModel>> watchAllLogs() {
    return _client.dailyLogModels.where().sortByDateDesc().watch();
  }

  @override
  Future<bool> deleteLog(String uuid) async {
    final result = await _client.writeAsync(
      (isar) {
        return isar.dailyLogModels.delete(uuid.fastHash());
      },
    );

    return result;
  }
}
