import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';

abstract class DailyLogsRepository {
  Future<DailyLogEntity?> getLogByDate(DateTime date);
  Future<void> saveLog(DailyLogEntity log);
  Future<void> deleteLog(String id);
  Future<List<DailyLogEntity>> getLogsForRange(DateTime start, DateTime end);
  Stream<List<DailyLogEntity>> watchLogs();
}
