import 'package:flutter/material.dart';

class WeekdayLabelCard extends StatelessWidget {
  const WeekdayLabelCard({
    required this.isWeekend,
    required this.label,
    super.key,
  });

  final String label;
  final bool isWeekend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Expanded(
      child: Container(
        padding: const .symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: .circular(4),
          color: colorScheme.surface,
        ),
        child: Center(
          child: Text(
            label,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: .bold,
              color: isWeekend
                  ? colorScheme.error
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
