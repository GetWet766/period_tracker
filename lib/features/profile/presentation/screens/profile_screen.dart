import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/features/learn/data/articles_data.dart';
import 'package:period_tracker/features/learn/presentation/widgets/article_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Profile settings
  String _userName = 'Пользователь';
  int _cycleLength = 28;
  int _periodDuration = 5;
  DateTime? _birthDate;

  // App settings
  bool _notificationsEnabled = true;
  bool _periodReminder = true;
  bool _ovulationReminder = true;
  bool _medicationReminder = true;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const TrackerAppBar(title: Text('Профиль')),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildProfileSection(context),
              const SizedBox(height: 16),
              _buildCycleSettingsSection(context),
              const SizedBox(height: 16),
              _buildNotificationsSection(context),
              const SizedBox(height: 16),
              _buildThemeSectionCard(context),
              const SizedBox(height: 16),
              _buildArticlesSection(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: ClipRRect(
        borderRadius: .circular(16),
        child: Column(
          spacing: 2,
          children: [
            Container(
              padding: const .all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: .circular(4),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primary,
                    child: Icon(
                      Icons.person,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _birthDate != null
                              ? 'Дата рождения: ${_formatDate(_birthDate!)}'
                              : 'Укажите дату рождения',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _editProfile,
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            _buildActionTile(
              context,
              icon: Icons.login,
              title: 'Войти в аккаунт',
              subtitle: 'Синхронизация данных между устройствами',
              onTap: _signIn,
            ),
            _buildActionTile(
              context,
              icon: Icons.people,
              title: 'Войти как партнёр',
              subtitle: 'Присоединиться к календарю партнёра',
              onTap: _signInAsPartner,
            ),
            _buildActionTile(
              context,
              icon: Icons.person_add,
              title: 'Пригласить партнёра',
              subtitle: 'Поделитесь календарём с близким человеком',
              onTap: _invitePartner,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCycleSettingsSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SectionContainer(
        title: 'Настройки цикла',
        child: Column(
          children: [
            _buildSliderTile(
              context,
              title: 'Длина цикла',
              value: _cycleLength,
              min: 21,
              max: 35,
              suffix: 'дн.',
              onChanged: (value) =>
                  setState(() => _cycleLength = value.round()),
            ),
            const SizedBox(height: 8),
            _buildSliderTile(
              context,
              title: 'Длительность менструации',
              value: _periodDuration,
              min: 3,
              max: 7,
              suffix: 'дн.',
              onChanged: (value) =>
                  setState(() => _periodDuration = value.round()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SectionContainer(
        title: 'Уведомления',
        child: ClipRRect(
          borderRadius: .circular(16),
          child: Column(
            spacing: 2,
            children: [
              _buildSwitchTile(
                context,
                title: 'Уведомления',
                subtitle: 'Включить все уведомления',
                value: _notificationsEnabled,
                onChanged: (value) =>
                    setState(() => _notificationsEnabled = value),
              ),
              if (_notificationsEnabled) ...[
                _buildSwitchTile(
                  context,
                  title: 'Напоминание о менструации',
                  subtitle: 'За 2 дня до начала',
                  value: _periodReminder,
                  onChanged: (value) => setState(() => _periodReminder = value),
                ),
                _buildSwitchTile(
                  context,
                  title: 'Напоминание об овуляции',
                  subtitle: 'В день овуляции',
                  value: _ovulationReminder,
                  onChanged: (value) =>
                      setState(() => _ovulationReminder = value),
                ),
                _buildSwitchTile(
                  context,
                  title: 'Напоминание о препаратах',
                  subtitle: 'Ежедневное напоминание',
                  value: _medicationReminder,
                  onChanged: (value) =>
                      setState(() => _medicationReminder = value),
                ),
                _buildSwitchTile(
                  context,
                  title: 'Напоминание о воде',
                  subtitle: 'Ежедневное напоминание',
                  value: _medicationReminder,
                  onChanged: (value) =>
                      setState(() => _medicationReminder = value),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSectionCard(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SectionContainer(
        title: 'Оформление',
        child: _buildThemeSelector(context),
      ),
    );
  }

  Widget _buildArticlesSection(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SectionContainer(
        title: 'Прочее',
        child: ClipRRect(
          borderRadius: .circular(16),
          child: Column(
            spacing: 2,
            children: [
              _buildActionTile(
                context,
                icon: Icons.newspaper,
                title: 'Статьи',
                subtitle: 'Полезные статьи о менструации',
                onTap: () => context.push('/learn'),
              ),
              _buildActionTile(
                context,
                icon: Icons.info_outline,
                title: 'О приложении',
                subtitle: 'Версия, информация и контакты',
                onTap: () => context.push('/about'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Material(
      color: colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                icon,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
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
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderTile(
    BuildContext context, {
    required String title,
    required int value,
    required double min,
    required double max,
    required String suffix,
    required ValueChanged<double> onChanged,
  }) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '$value $suffix',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          Slider(
            value: value.toDouble(),
            min: min,
            max: max,
            divisions: (max - min).round(),
            onChanged: onChanged,
            year2023: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        value: value,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return SegmentedButton<ThemeMode>(
      style: SegmentedButton.styleFrom(
        foregroundColor: colorScheme.onSurfaceVariant,
      ),
      segments: const [
        ButtonSegment(
          value: ThemeMode.system,
          icon: Icon(Icons.brightness_auto),
          label: Text(
            'Авто',
            overflow: .ellipsis,
          ),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode),
          label: Text(
            'Светлая',
            overflow: .ellipsis,
          ),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode),
          label: Text(
            'Тёмная',
            overflow: .ellipsis,
          ),
        ),
      ],
      selected: {_themeMode},
      onSelectionChanged: (selection) {
        setState(() => _themeMode = selection.first);
      },
    );
  }

  Future<void> _editProfile() async {
    final result = await context.push<Map<String, dynamic>>(
      '/profile/edit',
      extra: {
        'userName': _userName,
        'birthDate': _birthDate,
      },
    );
    if (result != null) {
      setState(() {
        _userName = result['name'] as String;
        _birthDate = result['birthDate'] as DateTime?;
      });
    }
  }

  void _signIn() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Функция входа в разработке')),
    );
  }

  void _signInAsPartner() {
    context.push('/partner-login');
  }

  void _invitePartner() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Функция приглашения в разработке')),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
