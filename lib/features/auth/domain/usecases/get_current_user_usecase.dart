import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/common/usecase/usecase.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase implements UseCaseWithoutParams<UserEntity?> {
  const GetCurrentUserUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity?>> call() async {
    return authRepository.getCurrentUser();
  }
}
