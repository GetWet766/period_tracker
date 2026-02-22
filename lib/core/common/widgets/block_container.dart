import 'package:flutter/material.dart';

class BlockContainer extends StatelessWidget {
  const BlockContainer({
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.child,
    this.bottomRounded = false,
    this.constraints,
    super.key,
  });

  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final bool bottomRounded;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      constraints: constraints,
      margin: margin,
      padding: padding ?? const .symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius:
            borderRadius ??
            .vertical(
              top: const .circular(28),
              bottom: bottomRounded ? const .circular(28) : .zero,
            ),
      ),
      child: child,
    );
  }
}
