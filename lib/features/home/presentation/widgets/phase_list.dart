import 'package:flutter/material.dart';

class PhaseList extends StatelessWidget {
  const PhaseList({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(borderRadius: .circular(16)),
      child: Column(
        spacing: 2,
        crossAxisAlignment: .stretch,
        children: children,
      ),
    );
  }
}
