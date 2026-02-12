import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/repositories/daily_logs_repository.dart';

class SaveDailyLogUseCase {
  const SaveDailyLogUseCase(this._repository);

  final DailyLogsRepository _repository;

  Future<void> call(DailyLogEntity log) {
    return _repository.saveLog(log);
  }
}
