import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/common/widgets/update_dialog.dart';
import 'package:period_tracker/core/services/update_service.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _version = '';
  bool _checkingUpdate = false;

  final _updateService = UpdateService(
    owner: 'GetWet766', // Замените на ваш username
    repo: 'period_tracker', // Замените на название репозитория
  );

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() => _version = packageInfo.version);
  }

  Future<void> _checkForUpdates() async {
    setState(() => _checkingUpdate = true);

    final update = await _updateService.checkForUpdate(includePrerelease: true);

    setState(() => _checkingUpdate = false);

    if (!mounted) return;

    if (update != null) {
      showUpdateDialog(
        context,
        update: update,
        updateService: _updateService,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('У вас установлена последняя версия')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const TrackerAppBar(title: Text('О приложении')),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 40,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Period Tracker',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Версия $_version',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _checkingUpdate ? null : _checkForUpdates,
                    icon: _checkingUpdate
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh),
                    label: Text(
                      _checkingUpdate ? 'Проверка...' : 'Проверить обновления',
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildInfoTile(
                    context,
                    icon: Icons.info_outline,
                    title: 'Описание',
                    subtitle:
                        'Приложение для отслеживания менструального цикла и планирования',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoTile(
                    context,
                    icon: Icons.security,
                    title: 'Конфиденциальность',
                    subtitle:
                        'Все данные хранятся локально на вашем устройстве',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoTile(
                    context,
                    icon: Icons.code,
                    title: 'Разработка',
                    subtitle: 'Сделано с ❤️ на Flutter',
                  ),
                  const Spacer(),
                  Text(
                    '© 2025 Period Tracker',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
