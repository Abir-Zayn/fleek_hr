import 'package:fleekhr/common/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  void toggleTheme() {
    // Emit the opposite theme based on the current state
    emit(state.brightness == Brightness.light ? darkTheme : lightTheme);
  }
}
