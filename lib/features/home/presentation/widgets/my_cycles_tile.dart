import 'package:flutter/material.dart';

class MyCyclesTile extends StatelessWidget {
  const MyCyclesTile({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  final String title;
  final Widget value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: .circular(4),
        ),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    title,
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    child: value,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Icon(
                icon,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
