import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/section_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/core/services/notification_service.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:period_tracker/features/profile/domain/entities/profile_entity.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:period_tracker/features/profile/presentation/cubit/profile/profile_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              _ProfileSection(
                onEditProfile: _editProfile,
                onSignIn: _signIn,
                onSignInAsPartner: _signInAsPartner,
                onInvitePartner: _invitePartner,
              ),
              const SizedBox(height: 16),
              const _CycleSettingsSection(),
              const SizedBox(height: 16),
              const _NotificationsSection(),
              const SizedBox(height: 16),
              _ThemeSectionCard(
                themeMode: _themeMode,
                onThemeChanged: (mode) => setState(() => _themeMode = mode),
              ),
              const SizedBox(height: 16),
              const _ArticlesSection(),
            ]),
          ),
        ],
      ),
    );
  }

  Future<void> _editProfile() async {
    final profileCubit = context.read<ProfileCubit>();
    final state = profileCubit.state;
    final profile = state.maybeWhen<ProfileEntity?>(
      error: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        return null;
      },
      loaded: (p) => p,
      orElse: () => null,
    );

    final result = await context.push<Map<String, dynamic>>(
      '/profile/edit',
      extra: {
        'displayName': profile?.displayName ?? 'Пользователь',
        'birthday': profile?.birthday,
      },
    );
    if (result != null) {
      await profileCubit.updateMyProfile(
        displayName: result['displayName'] as String?,
        birthday: result['birthday'] as DateTime?,
      );
    }
  }

  Future<void> _signIn() async => context.push('/auth/login');

  Future<void> _signInAsPartner() async => context.push('/partner-login');

  Future<void> _invitePartner() async => context.push('/invite-partner');
}

// Extracted section card decoration to avoid recreation
BoxDecoration _sectionDecoration(ColorScheme colorScheme) => BoxDecoration(
  color: colorScheme.surface,
  borderRadius: BorderRadius.circular(28),
);

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({
    required this.onEditProfile,
    required this.onSignIn,
    required this.onSignInAsPartner,
    required this.onInvitePartner,
  });

  final VoidCallback onEditProfile;
  final VoidCallback onSignIn;
  final VoidCallback onSignInAsPartner;
  final VoidCallback onInvitePartner;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _sectionDecoration(colorScheme),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          spacing: 2,
          children: [
            _ProfileHeader(onEditProfile: onEditProfile),
            _AuthActions(
              onSignIn: onSignIn,
              onSignInAsPartner: onSignInAsPartner,
              onInvitePartner: onInvitePartner,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onEditProfile});

  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        final profile = state.maybeWhen<ProfileEntity?>(
          loaded: (profile) => profile,
          orElse: () => null,
        );

        return Skeletonizer(
          enabled: profile == null,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Skeleton.keep(
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primary,
                    child: Icon(Icons.person, color: colorScheme.onPrimary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile?.displayName ?? 'Пользователь',
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getBirthdayText(profile),
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Skeleton.keep(
                  child: IconButton(
                    onPressed: onEditProfile,
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getBirthdayText(ProfileEntity? profile) {
    if (profile?.birthday == null) return 'Укажите дату рождения';
    final date = profile!.birthday!;
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return 'Дата рождения: $day.$month.${date.year}';
  }
}

class _AuthActions extends StatelessWidget {
  const _AuthActions({
    required this.onSignIn,
    required this.onSignInAsPartner,
    required this.onInvitePartner,
  });

  final VoidCallback onSignIn;
  final VoidCallback onSignInAsPartner;
  final VoidCallback onInvitePartner;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        final isGuest = state.maybeWhen(guest: () => true, orElse: () => false);

        return Column(
          spacing: 2,
          children: [
            if (isGuest) ...[
              _ActionTile(
                icon: Icons.login,
                title: 'Войти в аккаунт',
                subtitle: 'Синхронизация данных между устройствами',
                onTap: onSignIn,
              ),
              _ActionTile(
                icon: Icons.people,
                title: 'Войти как партнёр',
                subtitle: 'Присоединиться к календарю партнёра',
                onTap: onSignInAsPartner,
              ),
            ],
            if (!isGuest)
              _ActionTile(
                icon: Icons.person_add,
                title: 'Пригласить партнёра',
                subtitle: 'Поделитесь календарём с близким человеком',
                onTap: onInvitePartner,
              ),
            state.maybeWhen(
              authenticated: (_) => const _SignOutTile(),
              orElse: SizedBox.shrink,
            ),
          ],
        );
      },
    );
  }
}

class _SignOutTile extends StatelessWidget {
  const _SignOutTile();

  @override
  Widget build(BuildContext context) {
    return _ActionTile(
      icon: Icons.exit_to_app,
      title: 'Выйти из аккаунта',
      subtitle: 'Выйти из текущего аккаунта',
      onTap: () => _showSignOutDialog(context),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Выйти'),
        content: const Text('Вы действительно хотите выйти из аккаунта?'),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(),
            child: const Text('Назад'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: colorScheme.error),
            onPressed: () => context.read<AuthCubit>().signOut(),
            child: Text('Выйти', style: TextStyle(color: colorScheme.onError)),
          ),
        ],
      ),
    );
  }
}

class _CycleSettingsSection extends StatefulWidget {
  const _CycleSettingsSection();

  @override
  State<_CycleSettingsSection> createState() => _CycleSettingsSectionState();
}

class _CycleSettingsSectionState extends State<_CycleSettingsSection> {
  double _cycleLength = 28;
  double _periodLength = 5;
  bool _initialized = false;

  void _initFromProfile(ProfileEntity? profile) {
    if (!_initialized && profile != null) {
      _cycleLength = profile.cycleAvgLength.toDouble();
      _periodLength = profile.periodAvgLength.toDouble();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        final profile = state.maybeWhen<ProfileEntity?>(
          loaded: (profile) => profile,
          orElse: () => null,
        );
        final isLoading = profile == null;

        _initFromProfile(profile);

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: _sectionDecoration(colorScheme),
            child: SectionContainer(
              title: 'Настройки цикла',
              child: Column(
                children: [
                  _SliderTile(
                    title: 'Длина цикла',
                    value: _cycleLength,
                    min: 21,
                    max: 35,
                    suffix: 'дн.',
                    onChanged: isLoading
                        ? null
                        : (v) => setState(() => _cycleLength = v),
                    onChangeEnd: isLoading
                        ? null
                        : (v) => context.read<ProfileCubit>().updateMyProfile(
                            cycleAvgLength: v.round(),
                          ),
                  ),
                  const SizedBox(height: 8),
                  _SliderTile(
                    title: 'Длительность менструации',
                    value: _periodLength,
                    min: 3,
                    max: 7,
                    suffix: 'дн.',
                    onChanged: isLoading
                        ? null
                        : (v) => setState(() => _periodLength = v),
                    onChangeEnd: isLoading
                        ? null
                        : (v) => context.read<ProfileCubit>().updateMyProfile(
                            periodAvgLength: v.round(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NotificationsSection extends StatefulWidget {
  const _NotificationsSection();

  @override
  State<_NotificationsSection> createState() => _NotificationsSectionState();
}

class _NotificationsSectionState extends State<_NotificationsSection> {
  late final LocalStorageService _storage;
  late final NotificationService _notifications;
  late Map<String, dynamic> _settings;

  @override
  void initState() {
    super.initState();
    _storage = sl<LocalStorageService>();
    _notifications = sl<NotificationService>();
    _settings = _storage.getNotificationSettings();
  }

  Future<void> _saveSettings() async {
    await _storage.saveNotificationSettings(_settings);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _sectionDecoration(colorScheme),
      child: SectionContainer(
        title: 'Уведомления',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            spacing: 2,
            children: [
              _SwitchTile(
                title: 'Напоминание о менструации',
                subtitle: 'За ${_settings['periodReminderDays']} дн. до начала',
                value: _settings['periodReminder'] as bool,
                onChanged: (v) async {
                  setState(() => _settings['periodReminder'] = v);
                  await _saveSettings();
                },
              ),
              _SwitchTile(
                title: 'Напоминание об овуляции',
                subtitle: 'За день до овуляции',
                value: _settings['ovulationReminder'] as bool,
                onChanged: (v) async {
                  setState(() => _settings['ovulationReminder'] = v);
                  await _saveSettings();
                },
              ),
              _SwitchTile(
                title: 'Напоминание о препаратах',
                subtitle: 'В установленное время',
                value: _settings['medicationReminder'] as bool,
                onChanged: (v) async {
                  setState(() => _settings['medicationReminder'] = v);
                  await _saveSettings();
                },
              ),
              _SwitchTile(
                title: 'Напоминание о воде',
                subtitle: 'Каждые ${_settings['waterReminderInterval']} ч.',
                value: _settings['waterReminder'] as bool,
                onChanged: (v) async {
                  setState(() => _settings['waterReminder'] = v);
                  await _saveSettings();
                  if (v) {
                    await _notifications.scheduleWaterReminder(
                      intervalHours: _settings['waterReminderInterval'] as int,
                    );
                  } else {
                    await _notifications.cancelWaterReminder();
                  }
                },
              ),
              Material(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () async {
                    final granted = await _notifications.requestPermissions();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            granted
                                ? 'Разрешения получены'
                                : 'Разрешения не получены',
                          ),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.notifications, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text('Запросить разрешения на уведомления'),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeSectionCard extends StatelessWidget {
  const _ThemeSectionCard({
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _sectionDecoration(colorScheme),
      child: SectionContainer(
        title: 'Оформление',
        child: SegmentedButton<ThemeMode>(
          style: SegmentedButton.styleFrom(
            foregroundColor: colorScheme.onSurfaceVariant,
          ),
          segments: const [
            ButtonSegment(
              value: ThemeMode.system,
              icon: Icon(Icons.brightness_auto),
              label: Text('Авто', overflow: TextOverflow.ellipsis),
            ),
            ButtonSegment(
              value: ThemeMode.light,
              icon: Icon(Icons.light_mode),
              label: Text('Светлая', overflow: TextOverflow.ellipsis),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              icon: Icon(Icons.dark_mode),
              label: Text('Тёмная', overflow: TextOverflow.ellipsis),
            ),
          ],
          selected: {themeMode},
          onSelectionChanged: (s) => onThemeChanged(s.first),
        ),
      ),
    );
  }
}

class _ArticlesSection extends StatelessWidget {
  const _ArticlesSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _sectionDecoration(colorScheme),
      child: SectionContainer(
        title: 'Прочее',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            spacing: 2,
            children: [
              _ActionTile(
                icon: Icons.newspaper,
                title: 'Статьи',
                subtitle: 'Полезные статьи о менструации',
                onTap: () => context.push('/learn'),
              ),
              _ActionTile(
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
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
              Icon(icon, color: colorScheme.primary),
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
}

class _SliderTile extends StatelessWidget {
  const _SliderTile({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.suffix,
    required this.onChanged,
    required this.onChangeEnd,
  });

  final String title;
  final double value;
  final double min;
  final double max;
  final String suffix;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;

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
                '${value.round()} $suffix',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          Skeleton.keep(
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: (max - min).round(),
              onChanged: onChanged,
              onChangeEnd: onChangeEnd,
              // Opt into 2024 slider appearance
              // ignore: deprecated_member_use
              year2023: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
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
}
