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

class ForgotNewPasswordScreen extends StatefulWidget {
  const ForgotNewPasswordScreen({super.key});

  @override
  State<ForgotNewPasswordScreen> createState() =>
      _ForgotNewPasswordScreenState();
}

class _ForgotNewPasswordScreenState extends State<ForgotNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool isObscuredPassword = true;
  bool isObscuredConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
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
                      'Придумайте новый пароль',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Придумайте и запомните новый пароль.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),
                    FormInputField(
                      obscureText: isObscuredPassword,
                      controller: _passwordController,
                      labelText: 'Пароль',
                      hintText: '********',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      keyboardType: .visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: _toggleObscurePassword,
                        icon: Icon(
                          isObscuredPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.password(),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    FormInputField(
                      obscureText: isObscuredConfirmPassword,
                      controller: _passwordConfirmController,
                      labelText: 'Подтверждение пароля',
                      hintText: '********',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      keyboardType: .visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: _toggleObscureConfirmPassword,
                        icon: Icon(
                          isObscuredConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.equal(_passwordController.text),
                      ]),
                    ),
                    const Spacer(),
                    const SizedBox(height: 12),
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
                          onPressed: !isLoading ? _confirmNewPassword : null,
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
                                  'Обновить пароль',
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

  void _toggleObscurePassword() {
    setState(() {
      isObscuredPassword = !isObscuredPassword;
    });
  }

  void _toggleObscureConfirmPassword() {
    setState(() {
      isObscuredConfirmPassword = !isObscuredConfirmPassword;
    });
  }

  Future<void> _confirmNewPassword() async {
    if (_formKey.currentState!.validate()) {
      await context.push('/auth/forgot-password/success');
    }
  }
}
