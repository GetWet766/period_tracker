import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    this.backgroundColor,
    this.foregroundColor,
    this.iconColor,
    this.titleStyle,
    this.subtitleStyle,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.onLongPress,
    this.iconSize = 24,
    super.key,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final double iconSize;
  final void Function()? onPressed;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Material(
      color: backgroundColor ?? colorScheme.surfaceContainerLow,
      borderRadius: .circular(4),
      clipBehavior: .antiAlias,
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onPressed,
        child: Padding(
          padding: const .symmetric(vertical: 12, horizontal: 16),
          child: Row(
            spacing: 12,
            children: [
              if (leading != null)
                IconTheme(
                  data: IconThemeData(
                    color: iconColor ?? colorScheme.primary,
                  ),
                  child: leading!,
                ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: iconSize),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      DefaultTextStyle(
                        textAlign: .start,
                        style: textTheme.bodyLarge!
                            .copyWith(
                              fontWeight: .bold,
                              color:
                                  foregroundColor ??
                                  colorScheme.onSurfaceVariant,
                            )
                            .merge(titleStyle),
                        child: title,
                      ),
                      if (subtitle != null)
                        DefaultTextStyle(
                          textAlign: .start,
                          style: textTheme.bodyMedium!
                              .copyWith(
                                color:
                                    foregroundColor ??
                                    colorScheme.onSurfaceVariant,
                              )
                              .merge(subtitleStyle),
                          child: subtitle!,
                        ),
                    ],
                  ),
                ),
              ),
              if (trailing != null)
                IconTheme(
                  data: IconThemeData(
                    color: iconColor ?? colorScheme.primary,
                  ),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
