import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  const SignInUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<UserEntity> call(String email, String password) async =>
      authRepository.signIn(email, password);
}
