import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/core/services/notification_service.dart';
import 'package:period_tracker/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:period_tracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:period_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:period_tracker/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:period_tracker/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/cycle/data/datasource/cycle_local_datasource.dart';
import 'package:period_tracker/features/cycle/data/datasource/cycle_remote_datasource.dart';
import 'package:period_tracker/features/cycle/data/repositories/cycle_repository_impl.dart';
import 'package:period_tracker/features/cycle/domain/repositories/cycle_repository.dart';
import 'package:period_tracker/features/cycle/domain/usecases/create_cycle_log_usecase.dart';
import 'package:period_tracker/features/cycle/domain/usecases/delete_cycle_log_usecase.dart';
import 'package:period_tracker/features/cycle/domain/usecases/get_cycle_logs_usecase.dart';
import 'package:period_tracker/features/cycle/domain/usecases/get_partner_cycle_logs_usecase.dart';
import 'package:period_tracker/features/cycle/domain/usecases/update_cycle_log_usecase.dart';
import 'package:period_tracker/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:period_tracker/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:period_tracker/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:period_tracker/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:period_tracker/features/profile/domain/repositories/profile_repository.dart';
import 'package:period_tracker/features/profile/domain/usecases/create_partner_invite_usecase.dart';
import 'package:period_tracker/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:period_tracker/features/profile/domain/usecases/get_partner_connection_usecase.dart';
import 'package:period_tracker/features/profile/domain/usecases/get_partner_profile_usecase.dart';
import 'package:period_tracker/features/profile/domain/usecases/join_as_partner_usecase.dart';
import 'package:period_tracker/features/profile/domain/usecases/update_my_profile_usecase.dart';
import 'package:period_tracker/features/profile/presentation/cubit/invite/invite_cubit.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.I;

class DependencyInjection {
  static Future<void> init() async {
    await dotenv.load();

    // Core Services
    final prefs = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(prefs);
    sl.registerSingleton<LocalStorageService>(LocalStorageService(prefs));

    final notificationService = NotificationService();
    await notificationService.init();
    sl.registerSingleton<NotificationService>(notificationService);

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );

    sl
      ..registerSingleton(SharePlus.instance)
      ..registerSingleton<SupabaseClient>(Supabase.instance.client)
      // Auth
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
      )
      // Profile
      ..registerFactory(
        () => ProfileCubit(
          getMyProfileUseCase: sl(),
          updateMyProfileUseCase: sl(),
        ),
      )
      ..registerFactory(
        () => InviteCubit(createPartnerInviteUseCase: sl()),
      )
      ..registerLazySingleton(() => GetMyProfileUseCase(sl()))
      ..registerLazySingleton(() => UpdateMyProfileUseCase(sl()))
      ..registerLazySingleton(() => CreatePartnerInviteUseCase(sl()))
      ..registerLazySingleton(() => JoinAsPartnerUseCase(sl()))
      ..registerLazySingleton(() => GetPartnerProfileUseCase(sl()))
      ..registerLazySingleton(() => GetPartnerConnectionUseCase(sl()))
      ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(sl(), sl()),
      )
      ..registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDatasourceImpl(sl()),
      )
      ..registerLazySingleton<ProfileLocalDataSource>(
        () => ProfileLocalDataSourceImpl(sl()),
      )
      // Cycle
      ..registerFactory(
        () => CycleCubit(
          getCycleLogsUseCase: sl(),
          createCycleLogUseCase: sl(),
          updateCycleLogUseCase: sl(),
          deleteCycleLogUseCase: sl(),
        ),
      )
      ..registerLazySingleton(() => GetCycleLogsUseCase(sl()))
      ..registerLazySingleton(() => CreateCycleLogUseCase(sl()))
      ..registerLazySingleton(() => UpdateCycleLogUseCase(sl()))
      ..registerLazySingleton(() => DeleteCycleLogUseCase(sl()))
      ..registerLazySingleton(() => GetPartnerCycleLogsUseCase(sl()))
      ..registerLazySingleton<CycleRepository>(
        () => CycleRepositoryImpl(sl(), sl()),
      )
      ..registerLazySingleton<CycleRemoteDataSource>(
        () => CycleRemoteDataSourceImpl(sl()),
      )
      ..registerLazySingleton<CycleLocalDataSource>(
        () => CycleLocalDataSourceImpl(sl()),
      );
  }
}
