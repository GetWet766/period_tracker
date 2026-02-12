import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';

extension ButtonSizeExtension on ButtonStyle {
  ButtonStyle xs(BuildContext context) => copyWith(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    textStyle: WidgetStateProperty.all(context.textTheme.labelLarge),
    minimumSize: WidgetStateProperty.all(const Size(24, 32)),
  );

  ButtonStyle sm(BuildContext context) => copyWith(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
    textStyle: WidgetStateProperty.all(context.textTheme.labelLarge),
    minimumSize: WidgetStateProperty.all(const Size(32, 40)),
  );

  ButtonStyle md(BuildContext context) => copyWith(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
    textStyle: WidgetStateProperty.all(context.textTheme.titleMedium),
    minimumSize: WidgetStateProperty.all(const Size(48, 56)),
  );

  ButtonStyle lg(BuildContext context) => copyWith(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
    ),
    textStyle: WidgetStateProperty.all(context.textTheme.headlineSmall),
    minimumSize: WidgetStateProperty.all(const Size(96, 96)),
  );

  ButtonStyle xl(BuildContext context) => copyWith(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
    ),
    textStyle: WidgetStateProperty.all(context.textTheme.headlineLarge),
    minimumSize: WidgetStateProperty.all(const Size(128, 136)),
  );
}
