import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.title,
    this.child,
    this.onPressed,
    this.spacing = 12,
    this.crossAxisAlignment = .start,
    super.key,
  });

  final String title;
  final Widget? child;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: .zero,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        spacing: spacing,
        children: [
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: .bold,
                    ),
                  ),
                ),
                if (onPressed != null)
                  IconButton(
                    icon: const Icon(Symbols.chevron_right_rounded),
                    onPressed: onPressed,
                  ),
              ],
            ),
          ),
          ?child,
        ],
      ),
    );
  }
}
