import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/exceptions.dart';
import 'package:period_tracker/core/errors/failures.dart';
import 'package:period_tracker/core/network/connection_checker.dart';
import 'package:period_tracker/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource, this._connectionChecker);

  final AuthRemoteDataSource _remoteDataSource;
  final ConnectionChecker _connectionChecker;

  @override
  Stream<UserEntity?> get authStateChanges {
    return _remoteDataSource.authStateChanges.map((state) {
      final user = state.session?.user;
      return user != null ? _mapUser(user) : null;
    });
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      if (!await _connectionChecker.isConnected) {
        final session = _remoteDataSource.currentUserSession;

        if (session == null) {
          return const Left(AuthFailure('User not logged in!'));
        }

        return Right(_mapUser(session.user));
      }
      final user = _remoteDataSource.currentUser;
      if (user == null) {
        return const Left(AuthFailure('User not logged in!'));
      }

      return Right(_mapUser(user));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    return _getUser(
      () async => _remoteDataSource.signIn(email, password),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
    String email,
    String password,
  ) async {
    return _getUser(
      () async => _remoteDataSource.signUp(email, password),
    );
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final response = await _remoteDataSource.signOut();

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await _connectionChecker.isConnected) {
        return const Left(NetworkFailure());
      }
      final user = await fn();

      return Right(_mapUser(user));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  UserEntity _mapUser(User user) {
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
    );
  }
}
