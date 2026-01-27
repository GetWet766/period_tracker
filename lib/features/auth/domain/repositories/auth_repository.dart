import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(
    String email,
    String password,
  );
  Future<Either<Failure, void>> signOut();

  Stream<UserEntity?> get authStateChanges;
}
