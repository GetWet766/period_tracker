import 'package:flutter/material.dart';

enum TrackerAppBarType { basic, sliver }

class TrackerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TrackerAppBar({
    required this.title,
    this.expandedHeight,
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
  }) : _variant = TrackerAppBarType.sliver;

  const TrackerAppBar.basic({
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
  }) : expandedHeight = null,
       _variant = TrackerAppBarType.basic;

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
  final double? expandedHeight;
  final TrackerAppBarType _variant;

  @override
  Widget build(BuildContext context) {
    return _variant == .sliver
        ? SliverAppBar(
            title: title,
            actions: actions,
            backgroundColor: backgroundColor,
            flexibleSpace: flexibleSpace,
            bottom: bottom,
            actionsPadding: actionsPadding,
            centerTitle: centerTitle,
            floating: floating,
            leading: leading,
            pinned: pinned,
            primary: primary,
            shape: shape,
            titleSpacing: titleSpacing,
            surfaceTintColor: surfaceTintColor,
            expandedHeight: expandedHeight,
          )
        : AppBar(
            title: title,
            actions: actions,
            backgroundColor: backgroundColor,
            flexibleSpace: flexibleSpace,
            bottom: bottom,
            actionsPadding: actionsPadding,
            centerTitle: centerTitle,
            leading: leading,
            primary: primary,
            shape: shape,
            titleSpacing: titleSpacing,
            surfaceTintColor: surfaceTintColor,
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
