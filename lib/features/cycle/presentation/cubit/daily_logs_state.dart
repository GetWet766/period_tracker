part of 'daily_logs_cubit.dart';

@freezed
abstract class DailyLogsState with _$DailyLogsState {
  const factory DailyLogsState({
    required DateTime selectedDate,
    DailyLogEntity? currentLog,
    @Default(false) bool isLoading,
  }) = _DailyLogsState;
}
