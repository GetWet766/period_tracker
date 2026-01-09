import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.title,
    required this.child,
    this.spacing = 8,
    this.crossAxisAlignment = .start,
    super.key,
  });

  final String title;
  final Widget child;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: .zero,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        spacing: 12,
        children: [
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: .bold,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
