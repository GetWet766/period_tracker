import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:period_tracker/features/profile/domain/usecases/update_my_profile_usecase.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required GetMyProfileUseCase getMyProfileUseCase,
    required UpdateMyProfileUseCase updateMyProfileUseCase,
  }) : _getMyProfileUseCase = getMyProfileUseCase,
       _updateMyProfileUseCase = updateMyProfileUseCase,
       super(const ProfileState.initial());

  final GetMyProfileUseCase _getMyProfileUseCase;
  final UpdateMyProfileUseCase _updateMyProfileUseCase;

  Future<void> getMyProfile() async {
    emit(const ProfileState.loading());

    final result = await _getMyProfileUseCase();

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (profile) => emit(ProfileState.loaded(profile)),
    );
  }

  Future<void> updateMyProfile({
    String? displayName,
    DateTime? birthday,
    int? cycleAvgLength,
    int? periodAvgLength,
    String? avatarUrl,
  }) async {
    emit(const ProfileState.loading());

    final result = await _updateMyProfileUseCase(
      displayName: displayName,
      birthday: birthday,
      cycleAvgLength: cycleAvgLength,
      periodAvgLength: periodAvgLength,
      avatarUrl: avatarUrl,
    );

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (profile) => emit(ProfileState.loaded(profile)),
    );
  }
}
