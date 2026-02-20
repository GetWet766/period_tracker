import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
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
    this.children,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
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
  final List<Widget>? children;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _handleTap() {
    if (widget.children != null && widget.children!.isNotEmpty) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
      widget.onExpansionChanged?.call(_isExpanded);
    }
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final hasChildren = widget.children != null && widget.children!.isNotEmpty;

    final effectiveForegroundColor =
        widget.foregroundColor ?? colorScheme.onSurfaceVariant;
    final titleTextStyle = textTheme.bodyLarge!
        .copyWith(fontWeight: FontWeight.bold, color: effectiveForegroundColor)
        .merge(widget.titleStyle);

    return Material(
      color: widget.backgroundColor ?? colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onLongPress: widget.onLongPress,
            onTap: hasChildren ? _handleTap : widget.onPressed,
            child: Padding(
              padding: const .symmetric(vertical: 12, horizontal: 16),
              child: Row(
                spacing: 12,
                children: [
                  if (widget.leading != null)
                    IconTheme(
                      data: IconThemeData(
                        color: widget.iconColor ?? colorScheme.primary,
                      ),
                      child: widget.leading!,
                    ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: widget.iconSize),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          DefaultTextStyle(
                            textAlign: .start,
                            style: titleTextStyle,
                            child: widget.title,
                          ),
                          if (widget.subtitle != null)
                            DefaultTextStyle(
                              textAlign: .start,
                              style: textTheme.bodyMedium!
                                  .copyWith(color: effectiveForegroundColor)
                                  .merge(widget.subtitleStyle),
                              child: widget.subtitle!,
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.trailing != null)
                    IconTheme(
                      data: IconThemeData(
                        color: widget.iconColor ?? colorScheme.primary,
                      ),
                      child: widget.trailing!,
                    )
                  else if (hasChildren)
                    AnimatedRotation(
                      turns: _isExpanded ? -0.5 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more_rounded,
                        color: widget.iconColor ?? colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (hasChildren)
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _isExpanded
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.children!,
                    )
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}
