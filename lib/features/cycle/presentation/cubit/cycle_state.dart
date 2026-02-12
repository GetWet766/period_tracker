part of 'cycle_cubit.dart';

@freezed
abstract class CycleState with _$CycleState {
  const factory CycleState({
    CycleEntity? currentCycle,
    @Default([]) List<CycleEntity> history,
    @Default(false) bool isLoading,
  }) = _CycleState;
}
