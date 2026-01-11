import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:period_tracker/features/cycle/domain/entities/cycle_log_entity.dart';

part 'cycle_state.freezed.dart';

@freezed
class CycleState with _$CycleState {
  const factory CycleState.initial() = _Initial;
  const factory CycleState.loading() = _Loading;
  const factory CycleState.loaded(List<CycleLogEntity> logs) = _Loaded;
  const factory CycleState.error(String message) = _Error;
}
