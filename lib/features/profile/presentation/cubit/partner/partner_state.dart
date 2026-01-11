import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';

part 'partner_state.freezed.dart';

@freezed
class PartnerState with _$PartnerState {
  const factory PartnerState.initial() = _Initial;
  const factory PartnerState.loading() = _Loading;
  const factory PartnerState.loaded(ProfileEntity partner) = _Loaded;
  const factory PartnerState.error(String message) = _Error;
}
