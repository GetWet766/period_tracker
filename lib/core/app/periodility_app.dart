import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:periodility/core/app/app_providers.dart';
import 'package:periodility/core/common/cubit/theme/theme_cubit.dart';
import 'package:periodility/core/l10n/gen/app_localizations.dart';
import 'package:periodility/core/theme/theme.dart';

class Periodility extends StatelessWidget {
  const Periodility({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      builder: (routerConfig) => BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,

            title: 'Periodility',

            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              FormBuilderLocalizationsDelegate(),
            ],

            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,

            routerConfig: routerConfig,
          );
        },
      ),
    );
  }
}
