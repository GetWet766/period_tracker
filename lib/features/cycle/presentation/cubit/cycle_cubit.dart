import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/core/errors/failures.dart';
import 'package:periodility/features/cycle/domain/services/cycle_calculator.dart';
import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';
import 'package:periodility/features/cycle/domain/usecases/delete_cycle_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/finish_current_cycle_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/get_current_cycle_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/get_cycle_history_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/start_new_cycle_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/update_cycle_usecase.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'cycle_state.dart';
part 'cycle_cubit.freezed.dart';

class CycleCubit extends Cubit<CycleState> {
  CycleCubit({
    required DeleteCycleUseCase deleteCycleUseCase,
    required FinishCurrentCycleUseCase finishCurrentCycleUseCase,
    required GetCurrentCycleUseCase getCurrentCycleUseCase,
    required GetCycleHistoryUseCase getCycleHistoryUseCase,
    required StartNewCycleUseCase startNewCycleUseCase,
    required UpdateCycleUseCase updateCycleUseCase,
    required CycleCalculator cycleCalculator,
  }) : _deleteCycleUseCase = deleteCycleUseCase,
       _finishCurrentCycleUseCase = finishCurrentCycleUseCase,
       _getCurrentCycleUseCase = getCurrentCycleUseCase,
       _getCycleHistoryUseCase = getCycleHistoryUseCase,
       _startNewCycleUseCase = startNewCycleUseCase,
       _updateCycleUseCase = updateCycleUseCase,
       _cycleCalculator = cycleCalculator,
       super(const CycleState());

  final DeleteCycleUseCase _deleteCycleUseCase;
  final FinishCurrentCycleUseCase _finishCurrentCycleUseCase;
  final GetCurrentCycleUseCase _getCurrentCycleUseCase;
  final GetCycleHistoryUseCase _getCycleHistoryUseCase;
  final StartNewCycleUseCase _startNewCycleUseCase;
  final UpdateCycleUseCase _updateCycleUseCase;
  final CycleCalculator _cycleCalculator;

  StreamSubscription<Either<Failure, List<CycleEntity>>>? _historySubscription;

  @override
  Future<void> close() {
    _historySubscription?.cancel();
    return super.close();
  }

  Future<void> init() async {
    print('CycleCubit: init() called');
    emit(state.copyWith(isLoading: true));

    // Cancel existing subscription to avoid duplicates
    await _historySubscription?.cancel();

    // Load history first to calculate averages
    final historyStream = _getCycleHistoryUseCase();

    // Subscribe to stream
    _historySubscription = historyStream.listen((event) {
      event.fold(
        (l) => sl<Talker>().handle(
          'CycleCubit: History stream error: $l',
        ), // Log error
        (r) {
          sl<Talker>().info(
            'CycleCubit: History stream emitted ${r.length} cycles',
          );
          final sortedHistory = List<CycleEntity>.from(
            r,
          )..sort((a, b) => b.startDate.compareTo(a.startDate)); // Newest first

          // Calculate averages
          final avgCycle = _cycleCalculator.calculateAverageCycleLength(
            sortedHistory,
          );
          final avgPeriod = _cycleCalculator.calculateAveragePeriodLength(
            sortedHistory,
          );

          _updateStateWithData(
            history: sortedHistory,
            avgCycle: avgCycle,
            avgPeriod: avgPeriod,
          );
        },
      );
    });

    // Also fetch current explicitly
    print('CycleCubit: fetching current cycle...');
    (await _getCurrentCycleUseCase()).fold(
      (l) => print('CycleCubit: Init fetch current error: $l'),
      (r) {
        print('CycleCubit: Init fetch current success: $r');
        _updateStateWithData(current: r);
      },
    );
  }

  void _updateStateWithData({
    List<CycleEntity>? history,
    CycleEntity? current,
    int? avgCycle,
    int? avgPeriod,
  }) {
    sl<Talker>().info(
      'CycleCubit: _updateStateWithData(current: ${current?.id})',
    );
    final newHistory = history ?? state.history;
    final newAvgCycle = avgCycle ?? (state.currentCycle?.avg ?? 28); // Fallback
    // We need to store avg somewhere? CycleEntity has 'avg'.

    var newCurrent = current ?? state.currentCycle;

    if (newCurrent != null) {
      // Update current with calculated values
      final dayInfo = _cycleCalculator.getDayInfo(
        DateTime.now(),
        newCurrent,
        cycleLength: newAvgCycle,
      );

      newCurrent = newCurrent.copyWith(
        avg: newAvgCycle,
        phase: dayInfo?.phase,
        daysTo: dayInfo?.daysUntilNextPeriod,
      );
    }

    emit(
      state.copyWith(
        isLoading: false,
        history: newHistory,
        currentCycle: newCurrent,
      ),
    );
    sl<Talker>().info(
      'CycleCubit: state emitted with currentCycle: ${state.currentCycle?.id}',
    );
  }

  // Начать новый цикл (кнопка "У меня начались месячные")
  Future<void> startPeriod() async {
    final result = await _startNewCycleUseCase(startDate: DateTime.now());
    result.fold(
      (l) => sl<Talker>().handle('Error starting cycle: $l'),
      (r) async {
        // Refresh current manually
        (await _getCurrentCycleUseCase()).fold(
          (l) => sl<Talker>().handle('Error fetching current cycle: $l'),
          (r) => _updateStateWithData(current: r),
        );
      },
    );
  }

  // Завершить текущий цикл
  Future<void> endPeriod() async {
    await _finishCurrentCycleUseCase(endDate: DateTime.now());
    await init();
  }
}
