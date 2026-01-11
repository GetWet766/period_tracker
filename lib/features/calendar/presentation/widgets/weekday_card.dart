import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class WeekdayCard extends StatelessWidget {
  const WeekdayCard({
    required this.day,
    this.isToday = false,
    this.isSelected = false,
    this.isInRange = false,
    this.hasLog = false,
    super.key,
    this.rangeIndex,
    this.info,
  });

  final bool isSelected;
  final bool isToday;
  final String day;
  final String? rangeIndex;
  final bool isInRange;
  final bool hasLog;
  final List<String>? info;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(4),
        color: isSelected
            ? colorScheme.primary
            : isToday || isInRange
            ? colorScheme.primaryContainer
            : colorScheme.surface,
      ),
      child: Stack(
        children: [
          if (rangeIndex != null)
            Positioned(
              top: 4,
              right: 4,
              child: Text(
                rangeIndex!,
                style: textTheme.bodySmall?.copyWith(
                  color: isSelected
                      ? colorScheme.onPrimary
                      : isToday || isInRange
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          Center(
            child: Text(
              day,
              style: textTheme.titleMedium?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimary
                    : isToday || isInRange
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (rangeIndex != null)
            Positioned(
              bottom: 4,
              right: 4,
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedGiveBlood,
                color: isSelected
                    ? colorScheme.onPrimary
                    : isToday || isInRange
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                size: 12,
              ),
            ),
          if (hasLog && rangeIndex == null)
            Positioned(
              bottom: 4,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
