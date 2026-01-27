import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/block_container.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:pinput/pinput.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ForgotOtpScreen extends StatefulWidget {
  const ForgotOtpScreen({super.key});

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool canResend = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        keyboardDismissBehavior: .onDrag,
        slivers: [
          TrackerAppBar(
            title: const Text('Сброс пароля'),
            backgroundColor: colorScheme.surfaceContainerLow,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: BlockContainer(
              backgroundColor: colorScheme.surfaceContainerLow,
              margin: const .only(top: 16),
              padding: .only(
                top: 20,
                left: 20,
                right: 20,
                bottom: bottomPadding > 0 ? bottomPadding : 20,
              ),
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    'Введите одноразовый код',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: .bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Мы отправили письмо Вам на эл. почту.'
                    ' Введите одноразовый код из письма.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Pinput(
                    controller: pinController,
                    autofocus: true,
                    defaultPinTheme: PinTheme(
                      width: 96,
                      height: 96,
                      textStyle: textTheme.headlineMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: .circular(16),
                        border: .all(color: colorScheme.outline),
                      ),
                    ),
                    cursor: Align(
                      alignment: .bottomCenter,
                      child: Container(
                        margin: const .only(bottom: 8),
                        width: 22,
                        height: 2,
                        color: colorScheme.outline,
                      ),
                    ),
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: _resetPassword,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Не пришел код?',
                    textAlign: .center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: canResend ? _resendOTP : null,
                    child: Text(
                      'Отправить повторно',
                      textAlign: .center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: canResend
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        error: (message) => sl<Talker>().handle(message),
                        orElse: () {},
                      );
                    },
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );

                      return FilledButton(
                        onPressed: !isLoading && pinController.text.length == 4
                            ? () => _resetPassword(pinController.text)
                            : null,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Продолжить',
                                style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _resendOTP() async {
    setState(() {
      canResend = false;
    });
    sl<Talker>().info('OTP is sended');
    Future.delayed(const Duration(minutes: 1), () {
      setState(() {
        canResend = true;
      });
    });
  }

  Future<void> _resetPassword(String code) async {
    await context.push('/auth/forgot-password/new-password');
  }
}
