import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.people,
                  size: 50,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Используйте вместе',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Приложение можно использовать вместе с партнёром. '
                'Делитесь календарём, чтобы близкий человек был в курсе вашего самочувствия.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildBenefitItem(
                      context,
                      icon: Icons.visibility,
                      text: 'Партнёр видит фазы вашего цикла',
                    ),
                    const SizedBox(height: 12),
                    _buildBenefitItem(
                      context,
                      icon: Icons.notifications,
                      text: 'Получает напоминания о важных днях',
                    ),
                    const SizedBox(height: 12),
                    _buildBenefitItem(
                      context,
                      icon: Icons.favorite,
                      text: 'Лучше понимает ваше состояние',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Вы сможете пригласить партнёра позже в настройках',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.push('/welcome/quiz/0'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: const Text('Продолжить'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
