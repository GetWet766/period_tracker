import 'package:flutter/material.dart';

class PhaseCard extends StatelessWidget {
  const PhaseCard({
    required this.foregroundColor,
    required this.backgroundColor,
    required this.title,
    super.key,
    this.icon,
    this.subtitle,
  });

  final Widget? icon;
  final Color foregroundColor;
  final Color backgroundColor;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const .all(12),
      decoration: BoxDecoration(
        borderRadius: .circular(4),
        color: backgroundColor,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(color: foregroundColor),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: textTheme.labelLarge?.copyWith(color: foregroundColor),
                ),
              ],
            ],
          ),
          if (icon != null)
            Positioned(
              bottom: 4,
              right: 4,
              child: IconTheme(
                data: IconThemeData(color: foregroundColor),
                child: icon!,
              ),
            ),
        ],
      ),
    );
  }
}
