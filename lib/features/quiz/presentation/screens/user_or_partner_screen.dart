import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:talker_flutter/talker_flutter.dart';

class UserOrPartnerScreen extends StatefulWidget {
  const UserOrPartnerScreen({super.key});

  @override
  State<UserOrPartnerScreen> createState() => _UserOrPartnerScreenState();
}

class _UserOrPartnerScreenState extends State<UserOrPartnerScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerLow,
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Text(
                'Выберите Вашу роль',
                textAlign: .center,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: .bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Пользователь ведет свой дневник.'
                '\nПартнер наблюдает за дневником пользователя.',
                textAlign: .center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              const SizedBox(height: 12),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  state.maybeWhen(
                    error: (message) => sl<Talker>().handle(message),
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );

                  return FilledButton(
                    onPressed: !isLoading ? () => _setRole(.user) : null,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Продолжить как пользователь',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                  );
                },
              ),
              const SizedBox(height: 12),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  state.maybeWhen(
                    error: (message) => sl<Talker>().handle(message),
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );

                  return FilledButton.tonal(
                    onPressed: !isLoading ? () => _setRole(.partner) : null,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Продолжить как партнер',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setRole(ProfileRole role) async {
    final storage = sl<LocalStorageService>();

    if (role == .user) {
      await storage.setUserRole('user');
      if (mounted) await context.push('/quiz');
    } else {
      await storage.setUserRole('partner');
      if (mounted) await context.push('/auth/partner-login');
    }
  }
}

enum ProfileRole {
  user,
  partner,
}
