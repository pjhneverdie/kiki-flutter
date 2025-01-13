library terms_of_use_screen;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import 'package:kiki/app/config/data/iconfig.dart';
import 'package:kiki/app/config/theme/app_assets.dart';
import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/app/walk_through/home/view/home_view/screen/home_screen.dart';
import 'package:kiki/app/walk_through/login/cubit/login_cubit.dart';
import 'package:kiki/app/walk_through/login/model/login_state.dart';
import 'package:kiki/app/walk_through/login/view/login_view/screen/login_screen.dart';
import 'package:kiki/app/walk_through/login/view/terms_of_use_view/screen/terms_of_use_web_screen.dart';
import 'package:kiki/app/walk_through/notice/view/notice_view/notice_screen.dart';
import 'package:kiki/common/component/custom_orientation_builder.dart';
import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/common/exception/global_exception_code.dart';
import 'package:kiki/common/util/toast_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/feature/member/service/member_service.dart';

part 'package:kiki/app/walk_through/login/view/terms_of_use_view/component/introduction.dart';

part 'package:kiki/app/walk_through/login/view/terms_of_use_view/component/terms_of_use.dart';

part 'package:kiki/app/walk_through/login/view/terms_of_use_view/component/agree_button.dart';

class TermsOfUseScreen extends StatefulWidget {
  static const String PATH = "/";

  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  final LoginCubit _loginCubit = getIt<LoginCubit>();

  Future<void> _getMember() async {
    await getIt<MemberService>().getMember().then((member) async {
      await getIt<LoginCubit>().login(
        tokens: null,
        member: member,
      );
    }).catchError((e, s) {
      if (e is CustomException &&
          e.exceptionCode == GlobalExceptionCode.INVALID_TOKEN) {
        FlutterNativeSplash.remove();
        return;
      } else if (e is CustomException &&
          e.exceptionCode == GlobalExceptionCode.SERVER_MAINTAINING) {
        if (mounted) context.go(NoticeScreen.PATH);
        return;
      } else if (e is CustomException &&
          e.exceptionCode == GlobalExceptionCode.INTERNAL_SERVER_ERROR) {
        if (mounted) {
          ToastUtil.showAppDefaultToast(context,
              message: e.exceptionCode.message);
          return;
        }
      }

      throw e;
    });
  }

  @override
  void initState() {
    super.initState();

    _getMember();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginCubit,
      listener: (context, state) {
        if (state is LoginStateLogin) context.go(HomeScreen.PATH);
      },
      child: Scaffold(
        backgroundColor: useColorMode(
          context,
          context.colors.strongWhite,
          context.colors.weakBlack,
        ),
        body: CustomOrientationBuilder(
          portraitBuilder: (context) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0.autoSizeW,
                    vertical: 40.0.autoSizeH,
                  ).copyWith(
                    top: 60.0.autoSizeH,
                  ),
                  child: const _Introduction(),
                ),
                Expanded(
                  child: Container(
                    color: useColorMode(
                      context,
                      context.colors.blueGray,
                      context.colors.middleBlack,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0.autoSizeW,
                            vertical: 40.0.autoSizeH,
                          ),
                          child: const _TermsOfUse(),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.0.autoSizeW,
                                ).copyWith(
                                  bottom: MediaQuery.viewPaddingOf(context)
                                              .bottom ==
                                          0
                                      ? 15.0.autoSizeH
                                      : MediaQuery.viewPaddingOf(context)
                                          .bottom,
                                ),
                                child: const _AgreeButton(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          landscapeBuilder: (context) {
            return Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0.autoSizeW,
                    vertical: 40..autoSizeH,
                  ).copyWith(
                    top: 60.0.autoSizeH,
                  ),
                  child: const _Introduction(),
                ),
                Expanded(
                  child: Container(
                    color: useColorMode(
                      context,
                      context.colors.blueGray,
                      context.colors.middleBlack,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0.autoSizeW,
                            vertical: 40.0.autoSizeH,
                          ).copyWith(
                            top: 60.0.autoSizeH,
                          ),
                          child: const _TermsOfUse(),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.0.autoSizeW,
                                ).copyWith(
                                  bottom: MediaQuery.viewPaddingOf(context)
                                              .bottom ==
                                          0
                                      ? 15.0.autoSizeH
                                      : MediaQuery.viewPaddingOf(context)
                                          .bottom,
                                ),
                                child: const _AgreeButton(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
