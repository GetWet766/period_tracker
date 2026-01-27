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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            title: const Text('Авторизация'),
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
                      'Добро пожаловать!',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Войдите в аккаунт и продолжите использовать приложение'
                      ' для отслеживания цикла!',
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
                      obscureText: isObscured,
                      controller: _passwordController,
                      labelText: 'Пароль',
                      hintText: '********',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      keyboardType: .visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: _toggleObscurePassword,
                        icon: Icon(
                          isObscured
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _forgotPassword,
                      child: Text(
                        'Забыли пароль?',
                        textAlign: .end,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
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
                          onPressed: !isLoading ? _signIn : null,
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
                                  'Войти',
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
      isObscured = !isObscured;
    });
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      await context.read<AuthCubit>().signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  Future<void> _forgotPassword() async {
    await context.push('/auth/forgot-password');
  }
}
