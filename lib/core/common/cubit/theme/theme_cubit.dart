import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.system));

  void setTheme(ThemeMode mode) {
    emit(ThemeState(mode));
  }

  void setLightTheme() {
    emit(const ThemeState(ThemeMode.light));
  }

  void setDarkTheme() {
    emit(const ThemeState(ThemeMode.dark));
  }

  void setSystemTheme() {
    emit(const ThemeState(ThemeMode.system));
  }
}
