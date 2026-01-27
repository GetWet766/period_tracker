import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.message = 'An unexpected error occurred,']);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Ошибка сервера']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Ошибка кэша']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Нет подключения к интернету']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Ошибка авторизации']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Неизвестная ошибка']);
}
