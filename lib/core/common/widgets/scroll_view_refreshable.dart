import 'package:flutter/material.dart';

class ScrollViewRefreshable extends StatelessWidget {
  const ScrollViewRefreshable({
    required this.headerSliverBuilder,
    required this.child,
    required this.onRefresh,
    super.key,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final NestedScrollViewHeaderSliversBuilder headerSliverBuilder;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: headerSliverBuilder,
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: child,
      ),
    );
  }
}
