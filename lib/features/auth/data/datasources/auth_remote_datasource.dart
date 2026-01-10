import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  User? get currentUser;
  Stream<AuthState> get authStateChanges;

  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password, String name);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);

  final SupabaseClient _client;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  @override
  Future<User> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) throw Exception('Login failed: User is null');
    return response.user!;
  }

  @override
  Future<User> signUp(String email, String password, String username) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );

    if (response.user == null) throw Exception('Signup failed: User is null');
    return response.user!;
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
