import 'package:fleekhr/common/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  void toggleTheme() {
    emit(state == AppTheme.lightTheme
        ? AppTheme.darkTheme
        : AppTheme.lightTheme);
  }

  void setLightTheme() {
    emit(AppTheme.lightTheme);
  }

  void setDarkTheme() {
    emit(AppTheme.darkTheme);
  }
}
