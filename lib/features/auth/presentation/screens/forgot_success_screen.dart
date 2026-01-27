import 'package:flutter/material.dart';

class ForgotSuccessScreen extends StatefulWidget {
  const ForgotSuccessScreen({super.key});

  @override
  State<ForgotSuccessScreen> createState() => _ForgotSuccessScreenState();
}

class _ForgotSuccessScreenState extends State<ForgotSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: .circular(24),
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 40,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Пароль успешно обновлен!',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Теперь Вы можете войти в свой аккаунт с новым паролем.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => Navigator.of(context).popUntil(
                  (route) => route.settings.name == 'login',
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: Text(
                  'Войти',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
