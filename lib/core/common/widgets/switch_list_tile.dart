import 'package:flutter/material.dart';
import 'package:period_tracker/core/common/widgets/custom_list_tile.dart';

class SwitchListTile extends StatelessWidget {
  const SwitchListTile({
    required this.title,
    required this.value,
    this.backgroundColor,
    this.foregroundColor,
    this.titleStyle,
    this.subtitleStyle,
    this.subtitle,
    this.leading,
    this.onChanged,
    this.onPressed,
    this.onLongPress,
    super.key,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final bool value;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final void Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: title,
      onPressed: onPressed,
      onLongPress: onLongPress,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      subtitle: subtitle,
      leading: leading,
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }
}
