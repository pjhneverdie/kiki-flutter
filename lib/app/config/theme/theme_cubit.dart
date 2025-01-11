import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

abstract class AppThemeMode {
  final ThemeMode themeMode;

  AppThemeMode(this.themeMode);
}

class Light extends AppThemeMode {
  Light(super.themeMode);
}

class Dark extends AppThemeMode {
  Dark(super.themeMode);
}

@injectable
class ThemeCubit extends Cubit<AppThemeMode> {
  ThemeCubit(@factoryParam ThemeMode initThemeMode)
      : super(initThemeMode.name == "light"
            ? Light(initThemeMode)
            : Dark(initThemeMode));

  void toggleTheme() {
    if (state is Light) {
      emit(Dark(ThemeMode.dark));

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      emit(Light(ThemeMode.light));

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }
}
