import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/repositories/daily_logs_repository.dart';

class GetDailyLogsRangeUseCase {
  const GetDailyLogsRangeUseCase(this._repository);

  final DailyLogsRepository _repository;

  Future<List<DailyLogEntity>> call(DateTime start, DateTime end) {
    return _repository.getLogsForRange(start, end);
  }
}
