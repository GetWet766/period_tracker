import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/features/profile/presentation/cubit/invite/invite_cubit.dart';
import 'package:period_tracker/features/profile/presentation/cubit/invite/invite_state.dart';
import 'package:share_plus/share_plus.dart';

class InvitePartnerScreen extends StatefulWidget {
  const InvitePartnerScreen({super.key});

  @override
  State<InvitePartnerScreen> createState() => _InvitePartnerScreenState();
}

class _InvitePartnerScreenState extends State<InvitePartnerScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        slivers: [
          const TrackerAppBar(title: Text('Пригласить партнера')),
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
              child: BlocBuilder<InviteCubit, InviteState>(
                builder: (context, state) {
                  final code = state.maybeWhen(
                    codeReceived: (code) => code,
                    orElse: () => null,
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.people,
                            size: 40,
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Пригласите партнёра',
                        textAlign: TextAlign.center,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Сгенерируйте код и отправьте его партнёру, '
                        'чтобы он мог видеть ваш календарь цикла',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (code != null) ...[
                        _buildCodeDisplay(context, code),
                        const SizedBox(height: 16),
                        _buildCopyButton(context, code),
                      ] else
                        _buildGenerateButton(context),
                      const SizedBox(height: 24),
                      _buildInfoCard(context),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeDisplay(BuildContext context, String code) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(code.length, (index) {
        return Padding(
          padding: EdgeInsets.only(left: index > 0 ? 8 : 0),
          child: Container(
            width: 48,
            height: 56,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              code[index],
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildGenerateButton(BuildContext context) {
    return FilledButton.icon(
      onPressed: _isLoading ? null : _generateCode,
      icon: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.refresh),
      label: const Text('Сгенерировать код'),
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
      ),
    );
  }

  Widget _buildCopyButton(BuildContext context, String code) {
    final colorScheme = ColorScheme.of(context);

    return FilledButton.icon(
      onPressed: () => _shareCode(code),
      icon: const Icon(Icons.share),
      label: const Text('Поделиться кодом'),
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        backgroundColor: colorScheme.primary,
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
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
          Text(
            'Что сможет видеть партнёр:',
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoItem(context, Icons.calendar_today, 'Календарь цикла'),
          const SizedBox(height: 8),
          _buildInfoItem(context, Icons.water_drop, 'Фазы менструации'),
          const SizedBox(height: 8),
          _buildInfoItem(context, Icons.mood, 'Прогноз самочувствия'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 12),
        Text(text, style: textTheme.bodyMedium),
      ],
    );
  }

  Future<void> _generateCode() async {
    setState(() => _isLoading = true);

    // Имитация запроса к серверу
    await context.read<InviteCubit>().createPartnerInvite();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _shareCode(String code) async {
    final box = context.findRenderObject() as RenderBox?;

    await sl<SharePlus>().share(
      ShareParams(
        text:
            'Присоединяйся ко мне в Period Tracker!\n'
            'Мой код приглашения: $code',
        subject: 'Invite Partner',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }
}
