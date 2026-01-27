import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/common/usecase/usecase.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase implements UseCaseWithoutParams<void> {
  const SignOutUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call() async {
    return authRepository.signOut();
  }
}
