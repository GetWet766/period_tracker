import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_state.freezed.dart';

@freezed
class InviteState with _$InviteState {
  const factory InviteState.initial() = _Initial;
  const factory InviteState.loading() = _Loading;
  const factory InviteState.codeReceived(String code) = _CodeReceived;
  const factory InviteState.error(String message) = _Error;
}
