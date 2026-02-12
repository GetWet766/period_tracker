import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _seedColor = Colors.pink;

  static final ThemeData light = _buildTheme(Brightness.light);
  static final ThemeData dark = _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: colorScheme.surfaceContainerLow,

      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          letterSpacing: .2,
        ),
      ),

      appBarTheme: AppBarThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: .vertical(
            bottom: .circular(28),
          ),
        ),
      ),

      navigationRailTheme: NavigationRailThemeData(
        selectedIconTheme: IconThemeData(
          size: 24,
          color: colorScheme.onSecondaryContainer,
          fill: 1,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: colorScheme.onSurfaceVariant,
          fill: 0,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              size: 24,
              color: colorScheme.onSecondaryContainer,
              fill: 1,
            );
          }
          return IconThemeData(
            size: 24,
            color: colorScheme.onSurfaceVariant,
            fill: 0,
          );
        }),
      ),
    );
  }
}
