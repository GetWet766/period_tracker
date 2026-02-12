import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    required this.color,
    required this.icon,
    this.containerSize = 48,
    this.iconSize = 24,
    super.key,
  });

  final Color color;
  final IconData icon;
  final double iconSize;
  final double containerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: iconSize,
      ),
    );
  }
}
