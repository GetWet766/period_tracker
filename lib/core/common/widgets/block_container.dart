import 'package:flutter/material.dart';

class BlockContainer extends StatelessWidget {
  const BlockContainer({
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.child,
    super.key,
  });

  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      margin: margin,
      padding: padding ?? const .all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: borderRadius ?? .circular(28),
      ),
      child: child,
    );
  }
}
