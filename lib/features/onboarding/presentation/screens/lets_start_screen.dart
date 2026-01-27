import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';

class LetsStartScreen extends StatefulWidget {
  const LetsStartScreen({super.key});

  @override
  State<LetsStartScreen> createState() => _LetsStartScreenState();
}

class _LetsStartScreenState extends State<LetsStartScreen> {
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
            children: [
              const Spacer(),
              Text(
                'Давайте начнем!',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: .bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Мы рады Вас видеть в нашем приложении!'
                ' Выберите способ удобный способ авторизации.',
                textAlign: .center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const .fromHeight(56),
                ),
                onPressed: _signInWithYandexId,
                icon: Image.asset(
                  'assets/icons/yandex-logo.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  'Продолжить с Яндекс ID',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const .fromHeight(56),
                ),
                onPressed: _signInWithVkId,
                icon: Image.asset(
                  'assets/icons/vk-logo.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  'Продолжить с VK ID',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FilledButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const .fromHeight(56),
                ),
                onPressed: _signIn,
                child: Text(
                  'Войти',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              FilledButton.tonal(
                style: OutlinedButton.styleFrom(
                  minimumSize: const .fromHeight(56),
                ),
                onPressed: _signUp,
                child: Text(
                  'Зарегистрироваться',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const .fromHeight(56),
                ),
                onPressed: _signInAsGuest,
                child: Text(
                  'Продолжить как гость',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _toPrivacyPolicy,
                child: Text(
                  'Политика конфиденциальности',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: _toTermsOfService,
                child: Text(
                  'Условия использования',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithYandexId() async {
    await sl<LocalStorageService>().setOnboardingCompleted(value: true);
    if (mounted) await context.push('/auth/login');
  }

  Future<void> _signInWithVkId() async {
    await sl<LocalStorageService>().setOnboardingCompleted(value: true);
    if (mounted) await context.push('/auth/login');
  }

  Future<void> _signIn() async {
    await sl<LocalStorageService>().setOnboardingCompleted(value: true);
    if (mounted) await context.push('/auth/login');
  }

  Future<void> _signUp() async {
    await sl<LocalStorageService>().setOnboardingCompleted(value: true);
    if (mounted) await context.push('/auth/register');
  }

  Future<void> _signInAsGuest() async {
    final storage = sl<LocalStorageService>();
    await storage.setOnboardingCompleted(value: true);
    await storage.setIsNewUser(value: true);
    // Automatically set role as 'user' for guests
    await storage.setUserRole('user');
    // Set guest mode in auth cubit - router will handle navigation
    await context.read<AuthCubit>().continueAsGuest();
  }

  Future<void> _toPrivacyPolicy() async {
    await context.push('/info/privacy-policy');
  }

  Future<void> _toTermsOfService() async {
    await context.push('/info/terms-of-service');
  }
}
