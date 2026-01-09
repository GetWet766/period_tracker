import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/scaffold_navigation.dart';
import 'package:period_tracker/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:period_tracker/features/care/presentation/screens/care_screen.dart';
import 'package:period_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:period_tracker/features/learn/presentation/screens/learn_list_screen.dart';
import 'package:period_tracker/features/learn/presentation/screens/learn_post_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/partner_login_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/partner_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/quiz_screen.dart';
import 'package:period_tracker/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/about_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:period_tracker/features/profile/presentation/screens/profile_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _config = GoRouter(
    initialLocation: '/welcome',
    navigatorKey: _rootNavigatorKey,
    routes: [
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
        path: '/partner-login',
        builder: (context, state) => const PartnerLoginScreen(),
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
                userName: extra?['userName'] as String? ?? 'Пользователь',
                birthDate: extra?['birthDate'] as DateTime?,
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
