import 'package:flutter_bloc/flutter_bloc.dart';
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
    try {
      final user = await _getCurrentUserUseCase();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (_) {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(const AuthState.loading());
    try {
      final user = await _signInUseCase(email, password);
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString()));
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    emit(const AuthState.loading());
    try {
      final user = await _signUpUseCase(
        email,
        password,
        name,
      );
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString()));
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> signOut() async {
    emit(const AuthState.loading());
    await _signOutUseCase();
    emit(const AuthState.unauthenticated());
  }
}
