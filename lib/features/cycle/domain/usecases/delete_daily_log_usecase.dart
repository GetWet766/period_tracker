import 'package:periodility/features/cycle/domain/repositories/daily_logs_repository.dart';

class DeleteDailyLogUseCase {
  const DeleteDailyLogUseCase(this._repository);

  final DailyLogsRepository _repository;

  Future<void> call(String id) {
    return _repository.deleteLog(id);
  }
}
