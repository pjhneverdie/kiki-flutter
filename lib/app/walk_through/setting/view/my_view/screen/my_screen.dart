library my_screen;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/app/walk_through/login/cubit/login_cubit.dart';
import 'package:kiki/app/walk_through/login/model/login_state.dart';
import 'package:kiki/app/walk_through/login/view/terms_of_use_view/screen/terms_of_use_screen.dart';
import 'package:kiki/app/walk_through/setting/view/account_view/screen/account_screen.dart';
import 'package:kiki/common/component/custom_orientation_builder.dart';
import 'package:kiki/common/component/loading_filter.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/common/util/toast_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';

part 'package:kiki/app/walk_through/setting/view/my_view/component/app_bar.dart';

part 'package:kiki/app/walk_through/setting/view/my_view/component/logout_button.dart';

part 'package:kiki/app/walk_through/setting/view/my_view/component/account_button.dart';

part 'package:kiki/app/walk_through/setting/view/my_view/component/divider.dart';

class MyScreen extends StatefulWidget {
  static const String PATH = "my";
  static const String FULL_PATH = "/home/my";

  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final LoginCubit _loginCubit = getIt<LoginCubit>();

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
    return BlocConsumer(
      bloc: _loginCubit,
      listener: (context, state) {
        if (state is LoginStateLogout) {
          context.go(TermsOfUseScreen.PATH);
        } else if (state is LoginStateOnException) {
          ToastUtil.showAppDefaultToast(
            context,
            message: state.customException.exceptionCode.message,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _LogoutButton(
                              onTap: () async => await _loginCubit.logout(),
                            ),
                            const _Divider(),
                            _AccountButton(
                              onTap: () => context.push(AccountScreen.FULL_PATH),
                            ),
                            const _Divider(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                landscapeBuilder: (context) {
                  return Column(
                    children: [
                      const _AppBar(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _LogoutButton(
                              onTap: () async => await _loginCubit.logout(),
                            ),
                            const _Divider(),
                            _AccountButton(
                              onTap: () => context.push(AccountScreen.PATH),
                            ),
                            const _Divider(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ...buildLoadingFilter(
              isLoading: state is LoginStateOnLoading,
            ),
          ],
        );
      },
    );
  }
}
