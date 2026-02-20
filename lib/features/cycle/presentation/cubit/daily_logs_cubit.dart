import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:periodility/features/cycle/domain/entities/daily_log_entity.dart';
import 'package:periodility/features/cycle/domain/entities/flow_level.dart';
import 'package:periodility/features/cycle/domain/usecases/get_daily_log_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/save_daily_log_usecase.dart';
import 'package:uuid/uuid.dart';

part 'daily_logs_state.dart';
part 'daily_logs_cubit.freezed.dart';

class DailyLogsCubit extends Cubit<DailyLogsState> {
  DailyLogsCubit(this._getDailyLogUseCase, this._saveDailyLogUseCase)
    : super(DailyLogsState(selectedDate: DateTime.now())) {
    loadLogForDate(state.selectedDate);
  }

  final GetDailyLogUseCase _getDailyLogUseCase;
  final SaveDailyLogUseCase _saveDailyLogUseCase;

  Future<void> loadLogForDate(DateTime date) async {
    emit(state.copyWith(isLoading: true, selectedDate: date));
    final log = await _getDailyLogUseCase(date);
    emit(state.copyWith(currentLog: log, isLoading: false));
  }

  Future<void> saveLog({
    List<String>? symptoms,
    String? mood,
    String? notes,
    List<FlowLevel>? flowLevels,
  }) async {
    final currentLog = state.currentLog;
    final newLog = DailyLogEntity(
      id: currentLog?.id ?? const Uuid().v4(),
      date: state.selectedDate,
      userId: currentLog?.userId, // Preserve or set if needed
      symptoms: symptoms,
      mood: mood,
      notes: notes,
      flowLevels: flowLevels,
    );

    await _saveDailyLogUseCase(newLog);
    emit(state.copyWith(currentLog: newLog));
  }
}
