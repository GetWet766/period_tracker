import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periodility/core/common/cubit/theme/theme_cubit.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/core/router/router.dart';
import 'package:periodility/features/articles/presentation/cubit/article_categories_cubit.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/features/cycle/presentation/cubit/daily_logs_cubit.dart';
import 'package:periodility/features/splash/presentation/cubit/splash_cubit.dart';

class AppProviders extends StatefulWidget {
  const AppProviders({
    required this.builder,
    super.key,
  });

  final Widget Function(RouterConfig<Object> routerConfig) builder;

  @override
  State<AppProviders> createState() => _AppProvidersState();
}

class _AppProvidersState extends State<AppProviders> {
  late final AppRouter _appRouter;
  late final SplashCubit _splashCubit;

  @override
  void initState() {
    super.initState();
    _splashCubit = sl<SplashCubit>();
    _appRouter = AppRouter(splashCubit: _splashCubit);
  }

  @override
  Future<void> dispose() async {
    await _splashCubit.close();
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _splashCubit,
        ),
        BlocProvider(
          create: (_) => sl<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<ArticlesCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<ArticleCategoriesCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<CycleCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<DailyLogsCubit>(),
        ),
      ],
      child: widget.builder(_appRouter.config),
    );
  }
}
