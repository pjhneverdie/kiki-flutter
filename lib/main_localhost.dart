import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/app/config/theme/theme_cubit.dart';
import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/app/di/setup_localhost.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await configureDependenciesLocalhost();

  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  final Size _size = const Size(360, 690);
  final bool _minTextAdapt = true;

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
    );

    return ScreenUtilInit(
      designSize: _size,
      minTextAdapt: _minTextAdapt,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => getIt<ThemeCubit>(
            param1: brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
          ),
          child: BlocBuilder<ThemeCubit, AppThemeMode>(
            builder: (context, state) {
              return MaterialApp.router(
                routerConfig: getIt<GoRouter>(),
                themeMode: state.themeMode,
                theme: ThemeData(
                  brightness: Brightness.light,
                  useMaterial3: false,
                ).copyWith(
                  extensions: [
                    AppColors.init(),
                  ],
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  useMaterial3: false,
                ).copyWith(
                  extensions: [
                    AppColors.init(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
