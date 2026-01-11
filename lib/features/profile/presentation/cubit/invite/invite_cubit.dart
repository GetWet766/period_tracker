import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker/features/profile/domain/usecases/create_partner_invite_usecase.dart';
import 'package:period_tracker/features/profile/presentation/cubit/invite/invite_state.dart';

class InviteCubit extends Cubit<InviteState> {
  InviteCubit({required CreatePartnerInviteUseCase createPartnerInviteUseCase})
    : _createPartnerInviteUseCase = createPartnerInviteUseCase,
      super(const InviteState.initial());

  final CreatePartnerInviteUseCase _createPartnerInviteUseCase;

  Future<void> createPartnerInvite() async {
    emit(const InviteState.loading());

    final result = await _createPartnerInviteUseCase();

    result.fold(
      (failure) => emit(InviteState.error(failure.message)),
      (code) => emit(InviteState.codeReceived(code)),
    );
  }
}
