import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:isar_plus/isar_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:periodility/core/common/cubit/theme/theme_cubit.dart';
import 'package:periodility/core/services/cycle_service.dart';
import 'package:periodility/core/services/notification_service.dart';
import 'package:periodility/features/articles/data/datasources/articles_local_datasource.dart';
import 'package:periodility/features/articles/data/repositories/articles_repository_impl.dart';
import 'package:periodility/features/articles/domain/repositories/articles_repository.dart';
import 'package:periodility/features/articles/domain/usecases/get_article_usecase.dart';
import 'package:periodility/features/articles/domain/usecases/get_articles_usecase.dart';
import 'package:periodility/features/articles/domain/usecases/get_categories_usecase.dart';
import 'package:periodility/features/articles/presentation/cubit/article_categories_cubit.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:periodility/features/cycle/data/datasource/cycle_local_datasource.dart';
import 'package:periodility/features/cycle/data/datasource/daily_logs_local_datasource.dart';
import 'package:periodility/features/cycle/data/models/cycle_model.dart';
import 'package:periodility/features/cycle/data/models/daily_log_model.dart';
import 'package:periodility/features/cycle/data/repositories/cycle_repository_impl.dart';
import 'package:periodility/features/cycle/data/repositories/daily_logs_repository_impl.dart';
import 'package:periodility/features/cycle/domain/repositories/cycle_repository.dart';
import 'package:periodility/features/cycle/domain/repositories/daily_logs_repository.dart';
import 'package:periodility/features/cycle/domain/services/cycle_calculator.dart';
import 'package:periodility/features/cycle/domain/usecases/delete_cycle_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/delete_daily_log_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/finish_current_cycle_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/get_current_cycle_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/get_cycle_history_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/get_daily_log_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/get_daily_logs_range_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/save_daily_log_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/start_new_cycle_usecase.dart';
import 'package:periodility/features/cycle/domain/usecases/update_cycle_usecase.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/features/cycle/presentation/cubit/daily_logs_cubit.dart';
import 'package:periodility/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  await _initSystem();

  // ARTICLES
  _articlesFeature();

  // CYCLES
  _cycleFeature();
}

Future<void> _initSystem() async {
  await initializeDateFormatting();

  await dotenv.load(fileName: 'dotenv');
  final talker = TalkerFlutter.init();

  final notificationService = NotificationService();
  await notificationService.init();

  String? path;
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    path = dir.path;
  } else {
    await Isar.initialize();
  }

  final isar = Isar.open(
    schemas: [CycleModelSchema, DailyLogModelSchema],
    engine: kIsWeb ? .sqlite : .isar,
    directory: path ?? '',
    inspector: false,
  );

  sl
    // Services
    ..registerLazySingleton<Talker>(() => talker)
    ..registerLazySingleton<NotificationService>(() => notificationService)
    ..registerLazySingleton(() => isar)
    // Cubits
    ..registerFactory(ThemeCubit.new)
    ..registerLazySingleton(
      () => SplashCubit(
        articleCategoriesCubit: sl(),
        articlesCubit: sl(),
        cycleCubit: sl(),
        dailyLogsCubit: sl(),
      )..initApplication(),
    );
}

void _articlesFeature() {
  sl
    // Cubits
    ..registerLazySingleton(
      () => ArticlesCubit(
        getArticleUseCase: sl(),
        getArticlesUseCase: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ArticleCategoriesCubit(
        getCategoriesUseCase: sl(),
      ),
    )
    // UseCases
    ..registerLazySingleton(() => GetArticleUseCase(sl()))
    ..registerLazySingleton(() => GetArticlesUseCase(sl()))
    ..registerLazySingleton(() => GetCategoriesUseCase(sl()))
    // Repositories
    ..registerLazySingleton<ArticlesRepository>(
      () => ArticlesRepositoryImpl(sl()),
    )
    // DataSources
    ..registerLazySingleton<ArticlesLocalDataSource>(
      ArticlesLocalDataSourceImpl.new,
    );
}

void _cycleFeature() {
  sl
    // Services
    ..registerLazySingleton(CycleService.new)
    // Cubits
    ..registerLazySingleton(
      () => CycleCubit(
        deleteCycleUseCase: sl(),
        finishCurrentCycleUseCase: sl(),
        getCurrentCycleUseCase: sl(),
        getCycleHistoryUseCase: sl(),
        startNewCycleUseCase: sl(),
        updateCycleUseCase: sl(),
        cycleCalculator: sl(),
      ),
    )
    ..registerLazySingleton(CycleCalculator.new)
    ..registerLazySingleton(
      () => DailyLogsCubit(
        sl(),
        sl(),
      ),
    )
    // UseCases
    ..registerLazySingleton(() => GetCurrentCycleUseCase(sl()))
    ..registerLazySingleton(() => GetCycleHistoryUseCase(sl()))
    ..registerLazySingleton(() => StartNewCycleUseCase(sl()))
    ..registerLazySingleton(() => FinishCurrentCycleUseCase(sl()))
    ..registerLazySingleton(() => DeleteCycleUseCase(sl()))
    ..registerLazySingleton(() => UpdateCycleUseCase(sl()))
    // Daily Logs UseCases
    ..registerLazySingleton(() => GetDailyLogUseCase(sl()))
    ..registerLazySingleton(() => SaveDailyLogUseCase(sl()))
    ..registerLazySingleton(() => DeleteDailyLogUseCase(sl()))
    ..registerLazySingleton(() => GetDailyLogsRangeUseCase(sl()))
    // Repositories
    ..registerLazySingleton<CycleRepository>(
      () => CycleRepositoryImpl(
        cycleService: sl(),
        localDataSource: sl(),
      ),
    )
    ..registerLazySingleton<DailyLogsRepository>(
      () => DailyLogsRepositoryImpl(sl()),
    )
    // DataSources
    ..registerLazySingleton<CycleLocalDataSource>(
      () => CycleLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<DailyLogsLocalDataSource>(
      () => DailyLogsLocalDataSourceImpl(sl()),
    );
}
