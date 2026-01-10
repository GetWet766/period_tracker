import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:period_tracker/features/auth/domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  // Приложение запускается, проверяем токен
  const factory AuthState.initial() = _Initial;
  // Идет процесс входа/регистрации
  const factory AuthState.loading() = _Loading;
  // Пользователь авторизован
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  // Пользователь не авторизован (гость)
  const factory AuthState.unauthenticated() = _Unauthenticated;
  // Ошибка
  const factory AuthState.error(String message) = _Error;
}
