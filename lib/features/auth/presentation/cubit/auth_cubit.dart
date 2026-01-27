import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
  }) : _signOutUseCase = signOutUseCase,
       _signUpUseCase = signUpUseCase,
       _signInUseCase = signInUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(const AuthState.initial());

  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  Future<void> checkAuthStatus() async {
    emit(const .loading());

    // Check if user was in guest mode
    final storage = sl<LocalStorageService>();
    if (storage.isGuest) {
      emit(const .guest());
      return;
    }

    final result = await _getCurrentUserUseCase();

    result.fold(
      (l) => emit(.error(l.message)),
      (user) => user != null
          ? emit(.authenticated(user))
          : emit(const .unauthenticated()),
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(const .loading());

    final result = await _signInUseCase(
      SignInParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (l) => emit(.error(l.message)),
      (user) => emit(.authenticated(user)),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(const .loading());

    final result = await _signUpUseCase(
      SignUpParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (l) => emit(.error(l.message)),
      (user) => emit(.authenticated(user)),
    );
  }

  Future<void> signOut() async {
    emit(const .loading());

    final result = await _signOutUseCase();

    result.fold(
      (l) => emit(.error(l.message)),
      (user) async {
        // Clear all local data first
        try {
          await sl<LocalStorageService>().clear();
        } catch (e) {
          // Continue with sign out even if local clear fails
        }
        emit(const .unauthenticated());
      },
    );
  }

  Future<void> continueAsGuest() async {
    // Persist guest mode flag
    await sl<LocalStorageService>().setIsGuest(value: true);
    emit(const .guest());
  }
}
