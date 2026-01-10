import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<UserEntity?> call() async => authRepository.getCurrentUser();
}
