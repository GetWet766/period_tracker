import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/features/onboarding/presentation/widgets/feature_item.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              const Spacer(),
              Hero(
                tag: 'splashAppLogo',
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: .circular(32),
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: 60,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Hero(
                tag: 'splashAppTitle',
                child: Text(
                  'Periodility',
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Ваш персональный помощник для отслеживания'
                ' менструального цикла',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              const FeatureItem(
                icon: Icons.calendar_month,
                title: 'Точные прогнозы',
                subtitle: 'Отслеживайте цикл и получайте напоминания',
              ),
              const SizedBox(height: 16),
              const FeatureItem(
                icon: Icons.people,
                title: 'Делитесь с партнёром',
                subtitle: 'Пригласите близкого человека в приложение',
              ),
              const SizedBox(height: 16),
              const FeatureItem(
                icon: Icons.lock,
                title: 'Конфиденциальность',
                subtitle:
                    'Доступ к Вашим данным есть только у Вас и Вашего партнера',
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => context.push('/welcome/lets-start'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: Text(
                  'Давайте начнем',
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
