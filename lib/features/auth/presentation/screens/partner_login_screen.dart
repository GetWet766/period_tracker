import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:period_tracker/core/common/widgets/tracker_app_bar.dart';
import 'package:period_tracker/core/injection/di.dart';
import 'package:period_tracker/core/services/local_storage_service.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:period_tracker/features/auth/presentation/cubit/auth_state.dart';
import 'package:period_tracker/features/profile/domain/usecases/join_as_partner_usecase.dart';

class PartnerLoginScreen extends StatefulWidget {
  const PartnerLoginScreen({super.key});

  @override
  State<PartnerLoginScreen> createState() => _PartnerLoginScreenState();
}

class _PartnerLoginScreenState extends State<PartnerLoginScreen> {
  static const _codeLength = 6;
  final List<String> _code = List.filled(_codeLength, '');
  final List<FocusNode> _focusNodes = List.generate(
    _codeLength,
    (_) => FocusNode(),
  );
  final List<TextEditingController> _controllers = List.generate(
    _codeLength,
    (_) => TextEditingController(),
  );

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isLoading = false;
  bool _isRegisterMode = false;
  int _currentStep = 0; // 0 = auth, 1 = code

  String get _fullCode => _code.join();

  bool get _isAuthenticated {
    final state = context.read<AuthCubit>().state;
    return state.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );
  }

  @override
  void initState() {
    super.initState();

    // Если уже авторизован, сразу показываем ввод кода
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isAuthenticated) {
        setState(() => _currentStep = 1);
      }
    });
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (_) {
            setState(() => _currentStep = 1);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerLow,
        body: CustomScrollView(
          slivers: [
            const TrackerAppBar(title: Text('Войти как партнёр')),
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
                child: _currentStep == 0
                    ? _buildAuthStep(context)
                    : _buildCodeStep(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthStep(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

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
          _isRegisterMode ? 'Создайте аккаунт' : 'Войдите в аккаунт',
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Для просмотра календаря партнёра необходим аккаунт',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        if (_isRegisterMode) ...[
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Имя',
              filled: true,
              fillColor: colorScheme.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.person_outline),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
        ],
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Эл. почта',
            hintText: 'example@mail.com',
            filled: true,
            fillColor: colorScheme.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.mail_outline),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Пароль',
            filled: true,
            fillColor: colorScheme.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.lock_outline),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const Spacer(),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
            return FilledButton(
              onPressed: _canSubmitAuth && !isLoading ? _submitAuth : null,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isRegisterMode ? 'Зарегистрироваться' : 'Войти'),
            );
          },
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => setState(() => _isRegisterMode = !_isRegisterMode),
          child: Text(
            _isRegisterMode
                ? 'Уже есть аккаунт? Войти'
                : 'Нет аккаунта? Создать',
          ),
        ),
      ],
    );
  }

  bool get _canSubmitAuth {
    if (_isRegisterMode) {
      return _emailController.text.length >= 4 &&
          _passwordController.text.length >= 6 &&
          _usernameController.text.isNotEmpty;
    }
    return _emailController.text.length >= 4 &&
        _passwordController.text.length >= 6;
  }

  Future<void> _submitAuth() async {
    final authCubit = context.read<AuthCubit>();
    if (_isRegisterMode) {
      await authCubit.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } else {
      await authCubit.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  Widget _buildCodeStep(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

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
          'Введите код приглашения',
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Код из 6 символов, который вам отправил партнёр',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        _buildCodeInput(context),
        const SizedBox(height: 24),
        _buildInfoCard(context),
        const Spacer(),
        FilledButton(
          onPressed: _fullCode.length == _codeLength && !_isLoading
              ? _joinPartner
              : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Присоединиться'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCodeInput(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_codeLength, (index) {
        return Padding(
          padding: EdgeInsets.only(left: index > 0 ? 8 : 0),
          child: _buildCodeCell(context, index),
        );
      }),
    );
  }

  Widget _buildCodeCell(BuildContext context, int index) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final isFilled = _code[index].isNotEmpty;

    return SizedBox(
      width: 48,
      height: 56,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        style: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: isFilled
              ? colorScheme.primaryContainer.withValues(alpha: 0.3)
              : colorScheme.surfaceContainerLow,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
        ),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
          _UpperCaseTextFormatter(),
        ],
        onChanged: (value) => _onCodeChanged(index, value),
      ),
    );
  }

  void _onCodeChanged(int index, String value) {
    setState(() {
      _code[index] = value.toUpperCase();
    });

    if (value.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
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
            'Что вы сможете видеть:',
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
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

  Future<void> _joinPartner() async {
    setState(() => _isLoading = true);

    final useCase = sl<JoinAsPartnerUseCase>();
    final result = await useCase(_fullCode);

    if (mounted) {
      setState(() => _isLoading = false);

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка: ${failure.message}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (success) async {
          // Mark partner code as entered
          await sl<LocalStorageService>().setPartnerCodeEntered(value: true);
          // Mark setup as complete (no longer a new user)
          await sl<LocalStorageService>().setIsNewUser(value: false);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Вы успешно присоединились!'),
                backgroundColor: Colors.green,
              ),
            );
            // Use goNamed with replace to clear the navigation stack
            context.go('/splash');
          }
        },
      );
    }
  }
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
