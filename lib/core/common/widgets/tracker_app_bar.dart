import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';

class TrackerAppBar extends StatelessWidget {
  const TrackerAppBar({
    required this.title,
    this.centerTitle = true,
    this.floating = false,
    this.pinned = true,
    this.primary = true,
    this.backgroundColor,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.actionsPadding,
    this.shape,
    this.leading,
    this.titleSpacing,
    this.surfaceTintColor,
    super.key,
  });

  final Widget title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final EdgeInsetsGeometry? actionsPadding;
  final bool centerTitle;
  final bool floating;
  final bool pinned;
  final bool primary;
  final ShapeBorder? shape;
  final Widget? leading;
  final double? titleSpacing;
  final Color? surfaceTintColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return SliverAppBar(
      title: title,
      actions: actions,
      backgroundColor: backgroundColor ?? colorScheme.surface,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      actionsPadding: actionsPadding,
      centerTitle: centerTitle,
      floating: floating,
      leading: leading,
      pinned: pinned,
      primary: primary,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: .vertical(
              bottom: context.isDesktop
                  ? const .circular(28)
                  : const .circular(28),
            ),
          ),
      titleSpacing: titleSpacing,
      surfaceTintColor: surfaceTintColor,
    );
  }
}
