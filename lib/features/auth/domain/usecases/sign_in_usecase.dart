import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/common/usecase/usecase.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase implements UseCaseWithParams<UserEntity, SignInParams> {
  const SignInUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    return authRepository.signIn(params.email, params.password);
  }
}

class SignInParams {
  SignInParams({required this.email, required this.password});

  final String email;
  final String password;
}
