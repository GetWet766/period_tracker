import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:periodility/core/router/go_router_refresh_stream.dart';
import 'package:periodility/features/articles/presentation/screens/articles_list_screen.dart';
import 'package:periodility/features/articles/presentation/screens/article_detail_screen.dart';
import 'package:periodility/features/articles/presentation/screens/category_articles_screen.dart';
import 'package:periodility/features/calendar/presentation/modals/calendar_add_log_sheet.dart';
import 'package:periodility/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:periodility/features/home/presentation/screens/home_screen.dart';
import 'package:periodility/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:periodility/features/splash/presentation/screens/splash_screen.dart';
import 'package:periodility/features/care/presentation/screens/care_screen.dart';
import 'package:periodility/core/common/screens/error_screen.dart';
import 'package:scaffold_navigation/scaffold_navigation.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AppRouter {
  AppRouter({required SplashCubit splashCubit}) : _splashCubit = splashCubit;

  final SplashCubit _splashCubit;

  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _shellRouteIndexedStack = GlobalKey<StatefulNavigationShellState>(
    debugLabel: 'indexed_stack',
  );

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Symbols.home_rounded),
      label: 'Главная',
    ),
    NavigationDestination(
      icon: Icon(Symbols.calendar_month_rounded),
      label: 'Календарь',
    ),
    NavigationDestination(
      icon: Icon(Symbols.person_heart_rounded),
      label: 'Уход',
    ),
  ];

  late final GoRouter _config = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: SplashScreen.routePath,
    refreshListenable: GoRouterRefreshStream(_splashCubit.stream),
    redirect: _redirect,
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    routes: [
      GoRoute(
        path: SplashScreen.routePath,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/learn',
        builder: (context, state) => const ArticlesListScreen(),
        routes: [
          GoRoute(
            path: ':category_id',
            builder: (context, state) => CategoryArticlesScreen(
              id: state.pathParameters['category_id']!,
              title: state.uri.queryParameters['title'] ?? 'Статьи',
            ),
            routes: [
              GoRoute(
                path: ':article_id',
                builder: (context, state) => ArticleDetailScreen(
                  id: state.pathParameters['article_id']!,
                ),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        key: _shellRouteIndexedStack,
        builder: (context, state, navigationShell) => ScaffoldNavigation(
          destinations: _destinations,
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            initialLocation: '/home',
            routes: [
              GoRoute(
                name: 'home',
                path: '/home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: '/calendar',
            routes: [
              GoRoute(
                name: 'calendar',
                path: '/calendar',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CalendarScreen(),
                ),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'add-log',
                    pageBuilder: (context, state) {
                      final dateStr = state.uri.queryParameters['date'];
                      final date = dateStr != null
                          ? DateTime.parse(dateStr)
                          : DateTime.now();

                      return ModalSheetPage(
                        key: state.pageKey,
                        swipeDismissible: true,
                        swipeDismissSensitivity: const SwipeDismissSensitivity(
                          dismissalOffset: SheetOffset.proportionalToViewport(
                            0.4,
                          ),
                        ),
                        viewportBuilder: (context, child) => SheetViewport(
                          padding: EdgeInsets.only(
                            // Add the top padding to avoid the status bar.
                            top: MediaQuery.viewPaddingOf(context).top,
                          ),
                          child: child,
                        ),
                        child: CalendarAddLogSheet(date: date),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: '/care',
            routes: [
              GoRoute(
                name: 'care',
                path: '/care',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CareScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  GoRouter get config => _config;

  void dispose() {
    _config.dispose();
  }

  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    final isAppLoading = _splashCubit.state.maybeWhen(
      completed: () => false,
      orElse: () => true,
    );

    if (isAppLoading) {
      if (state.fullPath != SplashScreen.routePath) {
        return SplashScreen.routePath;
      }
      return null;
    } else if (!isAppLoading && state.fullPath == SplashScreen.routePath) {
      return '/home';
    }

    return null;
  }
}
