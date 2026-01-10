import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  const SignOutUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<void> call() async => authRepository.signOut();
}
