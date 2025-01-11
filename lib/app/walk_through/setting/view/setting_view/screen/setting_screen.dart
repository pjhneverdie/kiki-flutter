library setting_screen;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/app/config/theme/theme_cubit.dart';
import 'package:kiki/common/component/custom_orientation_builder.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';

part 'package:kiki/app/walk_through/setting/view/setting_view/component/app_bar.dart';

class SettingScreen extends StatefulWidget {
  static const String PATH = "setting";
  static const String FULL_PATH = "/home/setting";

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLight =
        context.watch<ThemeCubit>().state.themeMode == ThemeMode.light;

    return Scaffold(
      backgroundColor: useColorMode(
        context,
        context.colors.middleWhite,
        context.colors.strongBlack,
      ),
      body: CustomOrientationBuilder(
        portraitBuilder: (context) {
          return Column(
            children: [
              const _AppBar(),
              Expanded(
                  child: Switch(
                value: isLight,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme();
                },
                activeColor: Colors.blue,
              )),
            ],
          );
        },
        landscapeBuilder: (context) {
          return Column(
            children: [
              const _AppBar(),
              Expanded(
                  child: Switch(
                value: isLight,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme();
                },
                activeColor: Colors.blue,
              )),
            ],
          );
        },
      ),
    );
  }
}
