import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:period_tracker/core/network/connection_checker.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/core/services/notification_service.dart';
import 'package:period_tracker/core/theme/theme.dart';
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
import 'package:period_tracker/features/quiz/data/datasources/local_quiz_datasource.dart';
import 'package:period_tracker/features/quiz/data/datasources/remote_quiz_datasource.dart';
import 'package:period_tracker/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:period_tracker/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:period_tracker/features/quiz/domain/usecases/complete_quiz_usecase.dart';
import 'package:period_tracker/features/quiz/domain/usecases/get_quiz_answers_usecase.dart';
import 'package:period_tracker/features/quiz/domain/usecases/save_quiz_answer_usecase.dart';
import 'package:period_tracker/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GetIt sl = GetIt.I;

class DependencyInjection {
  static Future<void> init() async {
    await dotenv.load(fileName: 'dotenv');
    final talker = TalkerFlutter.init();
    sl.registerLazySingleton<Talker>(() => talker);

    // Core Services - Initialize Hive
    await LocalStorageService.init();
    sl.registerSingleton<LocalStorageService>(LocalStorageService.instance);

    final notificationService = NotificationService();
    await notificationService.init();
    sl.registerSingleton<NotificationService>(notificationService);

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );

    sl
      ..registerLazySingleton(AppTheme.new)
      ..registerSingleton(SharePlus.instance)
      ..registerSingleton(InternetConnection())
      ..registerSingleton<ConnectionChecker>(ConnectionCheckerImpl(sl()))
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
      ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl(), sl()),
      )
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
      )
      // Quiz
      ..registerFactory(
        () => QuizCubit(
          getQuizAnswersUseCase: sl(),
          saveQuizAnswerUseCase: sl(),
          completeQuizUseCase: sl(),
        ),
      )
      ..registerLazySingleton(() => GetQuizAnswersUseCase(sl()))
      ..registerLazySingleton(() => SaveQuizAnswerUseCase(sl()))
      ..registerLazySingleton(() => CompleteQuizUseCase(sl()))
      ..registerLazySingleton<QuizRepository>(
        () => QuizRepositoryImpl(
          localDataSource: sl(),
          remoteDataSource: sl(),
        ),
      )
      ..registerLazySingleton<LocalQuizDataSource>(
        () => LocalQuizDataSourceImpl(sl()),
      )
      ..registerLazySingleton<RemoteQuizDataSource>(
        () => RemoteQuizDataSourceImpl(sl()),
      );
  }
}
