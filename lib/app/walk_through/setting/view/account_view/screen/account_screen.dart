library account_screen;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/app/walk_through/login/cubit/login_cubit.dart';
import 'package:kiki/app/walk_through/login/model/login_state.dart';
import 'package:kiki/app/walk_through/login/view/terms_of_use_view/screen/terms_of_use_screen.dart';
import 'package:kiki/common/component/custom_orientation_builder.dart';
import 'package:kiki/common/component/loading_filter.dart';
import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/common/util/toast_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';
import 'package:kiki/feature/member/service/member_service.dart';

part 'package:kiki/app/walk_through/setting/view/account_view/component/app_bar.dart';

part 'package:kiki/app/walk_through/setting/view/account_view/component/withdraw_button.dart';

class AccountScreen extends StatefulWidget {
  static const String PATH = "account";
  static const String FULL_PATH = "/home/my/account";

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final LoginCubit _loginCubit = getIt<LoginCubit>();

  bool isLoading = false;

  Future<void> _deleteMember() async {
    setState(() {
      isLoading = true;
    });

    await getIt<MemberService>().deleteMember().then((value) async {
      await _loginCubit.logout();
    }).catchError((e, s) {
      if (e is CustomException && mounted) {
        ToastUtil.showAppDefaultToast(
          context,
          message: e.exceptionCode.message,
        );

        return;
      }

      throw e;
    });

    setState(() {
      isLoading = false;
    });
  }

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _AppBar(),
                      _WithdrawButton(
                        onTap: () async => await _deleteMember(),
                      ),
                      Container(
                        height: 1.0.autoSizeH,
                        color: useColorMode(
                          context,
                          context.colors.weakGray,
                          context.colors.strongBlack,
                        ),
                      ),
                    ],
                  );
                },
                landscapeBuilder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _AppBar(),
                      _WithdrawButton(
                        onTap: () async => await _deleteMember(),
                      ),
                      Container(
                        height: 1.0.autoSizeH,
                        color: useColorMode(
                          context,
                          context.colors.weakGray,
                          context.colors.strongBlack,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ...buildLoadingFilter(
              isLoading: isLoading,
            ),
          ],
        );
      },
    );
  }
}
