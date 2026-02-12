import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:periodility/core/utils/button_utils.dart';

class InvitePartnerBanner extends StatelessWidget {
  const InvitePartnerBanner({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              const CircleAvatar(
                radius: 26,
                child: Icon(Symbols.person_rounded),
              ),
              Icon(
                Symbols.link_2_rounded,
                color: colorScheme.primary,
              ),
              const CircleAvatar(
                radius: 26,
                child: Icon(Symbols.person_rounded),
              ),
            ],
          ),
          Text(
            'Укрепляйте доверие и заботу - помогите партнеру'
            ' понять, что Вы чувствуете',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom().sm(context),
            onPressed: onPressed,
            child: const Text('Пригласить'),
          ),
        ],
      ),
    );
  }
}
