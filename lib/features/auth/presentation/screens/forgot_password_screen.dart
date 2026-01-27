import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/block_container.dart';
import 'package:period_tracker/core/common/widgets/form_input_field.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Text(
                      'Забыли пароль?',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Не переживайте, его можно восстановить. Введите Вашу'
                      ' эл. почту и мы отправим Вам письмо с кодом'
                      ' для восстановления пароля.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),
                    FormInputField(
                      controller: _emailController,
                      labelText: 'Эл. почта',
                      hintText: 'example@mail.com',
                      prefixIcon: const Icon(Icons.mail_outline_rounded),
                      keyboardType: .emailAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
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
                          onPressed: !isLoading ? _sendOTP : null,
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
                                  'Восстановить',
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
          ),
        ],
      ),
    );
  }

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      // await context.read<AuthCubit>().resetPassword(
      //   email: _emailController.text,
      // );
      sl<Talker>().info('Success OTP sended');
      await context.push('/auth/forgot-password/otp-reset');
    }
  }
}
