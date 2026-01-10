import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  const SignUpUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<UserEntity> call(String email, String password, String name) async =>
      authRepository.signUp(email, password, name);
}
