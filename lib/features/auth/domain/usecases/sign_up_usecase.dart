import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/common/usecase/usecase.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase implements UseCaseWithParams<UserEntity, SignUpParams> {
  const SignUpUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return authRepository.signUp(
      params.email,
      params.password,
    );
  }
}

class SignUpParams {
  SignUpParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
