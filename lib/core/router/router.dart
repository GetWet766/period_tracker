import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/scaffold_navigation.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/router/go_router_refresh_stream.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:period_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:period_tracker/features/auth/presentation/screens/partner_login_screen.dart';
import 'package:period_tracker/features/auth/presentation/screens/register_screen.dart';
import 'package:period_tracker/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:period_tracker/features/care/presentation/screens/care_screen.dart';
import 'package:period_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:period_tracker/features/learn/presentation/screens/learn_list_screen.dart';
import 'package:period_tracker/features/learn/presentation/screens/learn_post_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/partner_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/quiz_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/about_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/invite_partner_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/profile_screen.dart';
import 'package:period_tracker/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  AppRouter(this._authCubit);
  final AuthCubit _authCubit;

  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  late final GoRouter _config = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/welcome',

    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    redirect: (context, state) {
      final authState = _authCubit.state;
      final storage = sl<LocalStorageService>();

      final isLoading = authState.maybeWhen(
        initial: () => true,
        loading: () => true,
        orElse: () => false,
      );
      final isLoggedIn = authState.maybeWhen(
        authenticated: (_) => true,
        guest: () => true,
        orElse: () => false,
      );
      final isGuest = authState.maybeWhen(
        guest: () => true,
        orElse: () => false,
      );
      final isSplash = state.matchedLocation == '/splash';
      final isOnboarding = state.matchedLocation.startsWith('/welcome');
      final isAuth = state.matchedLocation.startsWith('/auth');
      final isPartnerLogin = state.matchedLocation == '/partner-login';

      if (isLoading) {
        return '/splash';
      }

      // Всегда разрешаем доступ к partner-login
      if (isPartnerLogin) {
        return null;
      }

      // Если идёт процесс partner login, не редиректим на home
      if (storage.isPartnerLoginInProgress && isLoggedIn) {
        return '/partner-login';
      }

      if (!isLoggedIn && !isAuth && !isOnboarding && !isPartnerLogin) {
        return '/welcome';
      }

      if (isLoggedIn && isGuest && !isOnboarding) {
        return '/welcome/quiz/0';
      }

      if (isLoggedIn && (isAuth || isOnboarding || isSplash)) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
        routes: [
          GoRoute(
            path: 'partner',
            builder: (context, state) => const PartnerScreen(),
          ),
          GoRoute(
            path: 'quiz/:index',
            builder: (context, state) {
              final index =
                  int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
              return QuizScreen(questionIndex: index);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/invite-partner',
        builder: (context, state) => const InvitePartnerScreen(),
      ),
      GoRoute(
        path: '/partner-login',
        builder: (context, state) => const PartnerLoginScreen(),
      ),
      GoRoute(
        path: '/auth',
        redirect: (context, state) => null,
        routes: [
          GoRoute(
            path: 'login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return EditProfileScreen(
                displayName: extra?['displayName'] as String? ?? 'Пользователь',
                birthday: extra?['birthday'] as DateTime?,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/learn',
        pageBuilder: (context, state) =>
            const MaterialPage(child: LearnListScreen()),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) => LearnPostScreen(
              id: state.pathParameters['id']!,
              label: (state.extra! as Map<String, String>)['label'] ?? '',
            ),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldNavigation(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: CalendarScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/care',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: CareScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  GoRouter get config => _config;
}
