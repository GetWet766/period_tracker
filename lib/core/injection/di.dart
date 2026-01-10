import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:period_tracker/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:period_tracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:period_tracker/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.I;

class DependencyInjection {
  static Future<void> init() async {
    await dotenv.load();

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );

    sl
      ..registerFactory(
        () => AuthCubit(
          getCurrentUserUseCase: sl(),
          signInUseCase: sl(),
          signUpUseCase: sl(),
          signOutUseCase: sl(),
        ),
      )
      ..registerLazySingleton(() => SignInUseCase(sl()))
      ..registerLazySingleton(() => SignUpUseCase(sl()))
      ..registerLazySingleton(() => SignOutUseCase(sl()))
      ..registerLazySingleton(() => GetCurrentUserUseCase(sl()))
      ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
      ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()),
      );
  }
}
