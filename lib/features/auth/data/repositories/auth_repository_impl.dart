import 'package:period_tracker/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  UserEntity _mapUser(User user) {
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      username: user.userMetadata?['username'] as String,
    );
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _remoteDataSource.authStateChanges.map((state) {
      final user = state.session?.user;
      return user != null ? _mapUser(user) : null;
    });
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _remoteDataSource.currentUser;
    return user != null ? _mapUser(user) : null;
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final user = await _remoteDataSource.signIn(email, password);
    return _mapUser(user);
  }

  @override
  Future<UserEntity> signUp(
    String email,
    String password,
    String username,
  ) async {
    final user = await _remoteDataSource.signUp(email, password, username);
    return _mapUser(user);
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }
}
