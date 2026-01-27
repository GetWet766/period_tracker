import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/block_container.dart';
import 'package:period_tracker/core/common/widgets/form_input_field.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _privacyPolicyRecognizer = TapGestureRecognizer();
  final _termsOfServiceRecognizer = TapGestureRecognizer();

  bool isObscuredPassword = true;
  bool isObscuredConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _privacyPolicyRecognizer.onTap = _toPrivacyPolicy;
    _termsOfServiceRecognizer.onTap = _toTermsOfService;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _privacyPolicyRecognizer.dispose();
    _termsOfServiceRecognizer.dispose();
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
            title: const Text('Регистрация'),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Присоединяйтесь к нам!',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Зарегистрируйтесь чтобы начать отслеживать'
                      ' цикл уже сегодня!',
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
                    const SizedBox(height: 12),
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
                          authenticated: (_) async {
                            // Mark as new user after successful registration
                            await sl<LocalStorageService>().setIsNewUser(
                              value: true,
                            );
                          },
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
                          onPressed: !isLoading ? _signUp : null,
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
                                  'Зарегистрироваться',
                                  style: textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text.rich(
                      TextSpan(
                        text:
                            'Нажимая кнопку “Зарегистрироваться”, Вы'
                            ' соглашаетесь с ',
                        children: [
                          TextSpan(
                            text: 'политикой конфиденциальности',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                            ),
                            recognizer: _privacyPolicyRecognizer,
                          ),
                          const TextSpan(text: ' и '),
                          TextSpan(
                            text: 'условиями использования',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                            ),
                            recognizer: _termsOfServiceRecognizer,
                          ),
                          const TextSpan(text: ' сервиса'),
                        ],
                      ),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: .center,
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

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      await context.read<AuthCubit>().signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  Future<void> _toPrivacyPolicy() async {
    await context.push('/info/privacy-policy');
  }

  Future<void> _toTermsOfService() async {
    await context.push('/info/terms-of-service');
  }
}
