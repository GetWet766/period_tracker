import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/repositories/daily_logs_repository.dart';

class GetDailyLogUseCase {
  const GetDailyLogUseCase(this._repository);

  final DailyLogsRepository _repository;

  Future<DailyLogEntity?> call(DateTime date) {
    return _repository.getLogByDate(date);
  }
}
