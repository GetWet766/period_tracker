import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:period_tracker/core/common/widgets/scaffold_navigation.dart';
import 'package:period_tracker/core/router/go_router_refresh_stream.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:period_tracker/features/auth/presentation/screens/forgot_new_password_screen.dart';
import 'package:period_tracker/features/auth/presentation/screens/forgot_otp_screen.dart';
import 'package:period_tracker/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:period_tracker/features/auth/presentation/screens/forgot_success_screen.dart';
import 'package:period_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:period_tracker/features/auth/presentation/screens/partner_login_screen.dart';
import 'package:period_tracker/features/auth/presentation/screens/register_screen.dart';
import 'package:period_tracker/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:period_tracker/features/care/presentation/screens/care_screen.dart';
import 'package:period_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:period_tracker/features/learn/presentation/screens/learn_list_screen.dart';
import 'package:period_tracker/features/learn/presentation/screens/learn_post_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/lets_start_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/about_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/invite_partner_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/profile_screen.dart';
import 'package:period_tracker/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:period_tracker/features/quiz/presentation/screens/user_or_partner_screen.dart';
import 'package:period_tracker/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  AppRouter(this._authCubit);
  final AuthCubit _authCubit;

  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  late final GoRouter _config = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',

    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    redirect: (context, state) {
      final authState = _authCubit.state;
      final storage = sl<LocalStorageService>();

      final isLoading = authState.maybeWhen(
        initial: () => true,
        loading: () => true,
        orElse: () => false,
      );
      final isAuthenticated = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );
      final isGuest = authState.maybeWhen(
        guest: () => true,
        orElse: () => false,
      );
      final isLoggedIn = isAuthenticated || isGuest;

      final isSplashRoute = state.matchedLocation == '/splash';
      final isOnboardingRoute = state.matchedLocation.startsWith('/welcome');
      final isQuizRoute = state.matchedLocation.startsWith('/quiz');
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      final isPartnerLoginRoute =
          state.matchedLocation == '/auth/partner-login';
      final isHomeRoute =
          state.matchedLocation.startsWith('/home') ||
          state.matchedLocation.startsWith('/calendar') ||
          state.matchedLocation.startsWith('/care') ||
          state.matchedLocation.startsWith('/profile') ||
          state.matchedLocation.startsWith('/learn');

      // Get onboarding and setup status
      final isOnboardingCompleted = storage.isOnboardingCompleted;
      final isNewUser = storage.isNewUser;
      final userRole = storage.userRole;
      final isQuizCompleted = storage.isQuizCompleted;
      final isPartnerCodeEntered = storage.isPartnerCodeEntered;

      // 1. Show splash while loading
      if (isLoading && !isSplashRoute) {
        return '/splash';
      }

      // 2. Loading finished, redirect from splash
      if (!isLoading && isSplashRoute) {
        if (!isLoggedIn) {
          return '/welcome';
        }

        // Guest mode: always needs quiz
        if (isGuest) {
          if (!isQuizCompleted) {
            return '/quiz';
          }
          return '/home';
        }

        // Authenticated user
        if (!isOnboardingCompleted) {
          return '/welcome';
        }

        // New authenticated user flow: needs to select role and complete setup
        if (isNewUser) {
          if (userRole == null) {
            return '/quiz/user-or-partner';
          }
          if (userRole == 'user' && !isQuizCompleted) {
            return '/quiz';
          }
          if (userRole == 'partner' && !isPartnerCodeEntered) {
            return '/auth/partner-login';
          }
        }

        // Existing user or setup completed: go to home
        return '/home';
      }

      // 3. Guest mode routing
      if (isGuest) {
        // Guest trying to access auth routes -> redirect to home or quiz
        if (isAuthRoute || isOnboardingRoute) {
          return isQuizCompleted ? '/home' : '/quiz';
        }
        // Guest trying to access home without completing quiz
        if (isHomeRoute && !isQuizCompleted) {
          return '/quiz';
        }
        // Guest trying to access role selection -> skip to quiz
        if (state.matchedLocation == '/quiz/user-or-partner') {
          return '/quiz';
        }
        return null;
      }

      // 4. Not logged in -> show welcome/onboarding
      if (!isLoggedIn && !isOnboardingRoute && !isAuthRoute) {
        return '/welcome';
      }

      // 5. Authenticated but onboarding not completed -> show onboarding
      if (isAuthenticated && !isOnboardingCompleted && !isOnboardingRoute) {
        return '/welcome';
      }

      // 6. New authenticated user: onboarding completed but no role selected
      if (isAuthenticated &&
          isOnboardingCompleted &&
          isNewUser &&
          userRole == null &&
          !isQuizRoute &&
          !isAuthRoute) {
        return '/quiz/user-or-partner';
      }

      // 7. New authenticated user with user role: quiz not completed
      if (isAuthenticated &&
          isNewUser &&
          userRole == 'user' &&
          !isQuizCompleted &&
          state.matchedLocation != '/quiz') {
        return '/quiz';
      }

      // 8. New authenticated user with partner role: code not entered
      if (isAuthenticated &&
          isNewUser &&
          userRole == 'partner' &&
          !isPartnerCodeEntered &&
          !isPartnerLoginRoute) {
        return '/auth/partner-login';
      }

      // 9. Setup completed -> allow access to home
      if (isAuthenticated && isOnboardingCompleted) {
        // For new users, check if setup is complete
        if (isNewUser) {
          final setupComplete =
              userRole != null &&
              ((userRole == 'user' && isQuizCompleted) ||
                  (userRole == 'partner' && isPartnerCodeEntered));
          if (setupComplete &&
              (isOnboardingRoute || isAuthRoute || isQuizRoute)) {
            return '/home';
          }
        } else {
          // Existing users can access home directly
          if (isOnboardingRoute || isAuthRoute || isQuizRoute) {
            return '/home';
          }
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/welcome',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          child: const WelcomeScreen(),
        ),
        routes: [
          GoRoute(
            path: 'lets-start',
            builder: (context, state) => const LetsStartScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/quiz',
        builder: (context, state) => const QuizScreen(),
        routes: [
          GoRoute(
            path: 'user-or-partner',
            builder: (context, state) => const UserOrPartnerScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/auth',
        redirect: (context, state) => null,
        routes: [
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterScreen(),
          ),
          GoRoute(
            path: 'forgot-password',
            builder: (context, state) => const ForgotPasswordScreen(),
            routes: [
              GoRoute(
                path: 'otp-reset',
                builder: (context, state) => const ForgotOtpScreen(),
              ),
              GoRoute(
                path: 'new-password',
                builder: (context, state) => const ForgotNewPasswordScreen(),
              ),
              GoRoute(
                path: 'success',
                builder: (context, state) => const ForgotSuccessScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'partner-login',
            builder: (context, state) => const PartnerLoginScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/info',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: FlutterLogo(),
          ),
        ),
        routes: [
          GoRoute(
            path: 'privacy-policy',
            builder: (context, state) => const Scaffold(
              body: Center(
                child: FlutterLogo(),
              ),
            ),
          ),
          GoRoute(
            path: 'terms-of-service',
            builder: (context, state) => const Scaffold(
              body: Center(
                child: FlutterLogo(),
              ),
            ),
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
          GoRoute(
            path: 'invite-partner',
            builder: (context, state) => const InvitePartnerScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/learn',
        builder: (context, state) => const LearnListScreen(),
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
