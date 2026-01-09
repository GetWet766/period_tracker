import 'package:flutter/material.dart';
import 'package:period_tracker/core/services/update_service.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    required this.update,
    required this.onUpdate,
    required this.onLater,
    super.key,
  });

  final AppUpdate update;
  final VoidCallback onUpdate;
  final VoidCallback onLater;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            update.isPrerelease ? Icons.science : Icons.system_update,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
            update.isPrerelease ? 'Бета-версия' : 'Обновление',
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Доступна новая версия ${update.version}',
            style: textTheme.bodyLarge,
          ),
          if (update.releaseNotes.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Что нового:',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 150),
              child: SingleChildScrollView(
                child: Text(
                  update.releaseNotes,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: onLater,
          child: const Text('Позже'),
        ),
        FilledButton(
          onPressed: onUpdate,
          child: const Text('Обновить'),
        ),
      ],
    );
  }
}

Future<void> showUpdateDialog(
  BuildContext context, {
  required AppUpdate update,
  required UpdateService updateService,
}) async {
  return showDialog(
    context: context,
    builder: (context) => UpdateDialog(
      update: update,
      onUpdate: () {
        Navigator.pop(context);
        updateService.openDownloadPage(update.downloadUrl);
      },
      onLater: () => Navigator.pop(context),
    ),
  );
}
