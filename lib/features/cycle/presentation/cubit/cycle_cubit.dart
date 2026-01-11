import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';
import 'package:period_tracker/features/cycle/domain/usecases/create_cycle_log_usecase.dart';
import 'package:period_tracker/features/cycle/domain/usecases/delete_cycle_log_usecase.dart';
import 'package:period_tracker/features/cycle/domain/usecases/get_cycle_logs_usecase.dart';
import 'package:period_tracker/features/cycle/domain/usecases/update_cycle_log_usecase.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_state.dart';

class CycleCubit extends Cubit<CycleState> {
  CycleCubit({
    required GetCycleLogsUseCase getCycleLogsUseCase,
    required CreateCycleLogUseCase createCycleLogUseCase,
    required UpdateCycleLogUseCase updateCycleLogUseCase,
    required DeleteCycleLogUseCase deleteCycleLogUseCase,
  }) : _getCycleLogsUseCase = getCycleLogsUseCase,
       _createCycleLogUseCase = createCycleLogUseCase,
       _updateCycleLogUseCase = updateCycleLogUseCase,
       _deleteCycleLogUseCase = deleteCycleLogUseCase,
       super(const CycleState.initial());

  final GetCycleLogsUseCase _getCycleLogsUseCase;
  final CreateCycleLogUseCase _createCycleLogUseCase;
  final UpdateCycleLogUseCase _updateCycleLogUseCase;
  final DeleteCycleLogUseCase _deleteCycleLogUseCase;

  Future<void> loadCycleLogs({DateTime? from, DateTime? to}) async {
    emit(const CycleState.loading());

    final result = await _getCycleLogsUseCase(from: from, to: to);

    result.fold(
      (failure) => emit(CycleState.error(failure.message)),
      (logs) => emit(CycleState.loaded(logs)),
    );
  }

  Future<void> createLog({
    required DateTime date,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  }) async {
    final currentLogs = state.maybeWhen(
      loaded: (logs) => logs,
      orElse: () => <CycleLogEntity>[],
    );

    emit(const CycleState.loading());

    final result = await _createCycleLogUseCase(
      date: date,
      flowLevel: flowLevel,
      symptoms: symptoms,
      notes: notes,
    );

    result.fold(
      (failure) => emit(CycleState.error(failure.message)),
      (newLog) {
        final updatedLogs = [newLog, ...currentLogs];
        updatedLogs.sort((a, b) => b.date.compareTo(a.date));
        emit(CycleState.loaded(updatedLogs));
      },
    );
  }

  Future<void> updateLog({
    required String id,
    FlowLevel? flowLevel,
    List<String>? symptoms,
    String? notes,
  }) async {
    final currentLogs = state.maybeWhen(
      loaded: (logs) => logs,
      orElse: () => <CycleLogEntity>[],
    );

    final result = await _updateCycleLogUseCase(
      id: id,
      flowLevel: flowLevel,
      symptoms: symptoms,
      notes: notes,
    );

    result.fold(
      (failure) => emit(CycleState.error(failure.message)),
      (updatedLog) {
        final updatedLogs = currentLogs.map((log) {
          return log.id == id ? updatedLog : log;
        }).toList();
        emit(CycleState.loaded(updatedLogs));
      },
    );
  }

  Future<void> deleteLog(String id) async {
    final currentLogs = state.maybeWhen(
      loaded: (logs) => logs,
      orElse: () => <CycleLogEntity>[],
    );

    final result = await _deleteCycleLogUseCase(id);

    result.fold(
      (failure) => emit(CycleState.error(failure.message)),
      (_) {
        final updatedLogs = currentLogs.where((log) => log.id != id).toList();
        emit(CycleState.loaded(updatedLogs));
      },
    );
  }
}
