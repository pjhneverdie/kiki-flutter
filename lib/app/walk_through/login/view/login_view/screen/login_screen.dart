library login_screen;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

import 'package:kiki/app/config/data/iconfig.dart';
import 'package:kiki/app/config/theme/app_assets.dart';
import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/app/walk_through/home/view/home_view/screen/home_screen.dart';
import 'package:kiki/app/walk_through/login/cubit/login_cubit.dart';
import 'package:kiki/app/walk_through/login/dto/Tokens.dart';
import 'package:kiki/app/walk_through/login/model/login_state.dart';
import 'package:kiki/app/walk_through/login/view/login_view/screen/login_web_screen.dart';
import 'package:kiki/app/walk_through/notice/view/notice_view/notice_screen.dart';
import 'package:kiki/common/component/custom_orientation_builder.dart';
import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/common/exception/global_exception_code.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/common/util/toast_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';
import 'package:kiki/feature/member/service/member_service.dart';

part 'package:kiki/app/walk_through/login/view/login_view/component/kakao_login_button.dart';

class LoginScreen extends StatefulWidget {
  static const String PATH = "/login";
  static const String DEEP_LINK_PATH = "/app";

  final Tokens? _tokens;

  const LoginScreen({super.key, required Tokens? tokens}) : _tokens = tokens;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ChromeSafariBrowser _chromeSafariBrowser =
      LoginBrowser(onBrowserClosed: () {});

  void _login() {
    _chromeSafariBrowser.open(
      url: WebUri(getIt<IConfig>().kakaoLoginUrl),
    );
  }

  final LoginCubit _loginCubit = getIt<LoginCubit>();
  final MemberService _memberService = getIt<MemberService>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _loginCubit
        ..login(
          tokens: widget._tokens,
          member: null,
        ),
      listener: (context, state) async {
        if (state is LoginStateLogin) {
          /// 로그인 성공 시 홈으로
          ///
          context.go(HomeScreen.PATH);
        } else if (state is LoginStateTokenSaved) {
          /// 토큰 저장 성공 시 다시 로그인
          ///
          await _memberService.getMember().then((member) async {
            await _loginCubit.login(
              tokens: null,
              member: member,
            );
          }).catchError((e, s) {
            if (e is CustomException &&
                e.exceptionCode == GlobalExceptionCode.SERVER_MAINTAINING) {
              if (context.mounted) context.go(NoticeScreen.PATH);
              return;
            } else if (e is CustomException &&
                e.exceptionCode == GlobalExceptionCode.INTERNAL_SERVER_ERROR) {
              if (context.mounted) {
                ToastUtil.showAppDefaultToast(context,
                    message: e.exceptionCode.message);
                return;
              }
            }

            throw e;
          });
        } else if (state is LoginStateOnException) {
          /// LOGIN_FAILED 예외 발생 시
          ToastUtil.showAppDefaultToast(
            context,
            message: state.customException.exceptionCode.message,
          );
        }
      },
      builder: (context, state) {
        final bool isLoading =
            state is LoginStateOnLoading || state is LoginStateTokenSaved;

        return Scaffold(
          backgroundColor: useColorMode(
            context,
            context.colors.strongWhite,
            context.colors.weakBlack,
          ),
          body: CustomOrientationBuilder(
            portraitBuilder: (context) {
              return Column(
                children: [
                  SizedBox(
                    height: 50.0.autoSizeH,
                  ),
                  Expanded(
                    child: Image.asset(
                      useColorMode(
                        context,
                        AppAssets.splash_logo_light,
                        AppAssets.splash_logo_dark,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0.autoSizeW,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _KakaoLoginButton(
                              isLoading: isLoading,
                              onTap: _login,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            landscapeBuilder: (context) {
              return Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      useColorMode(
                        context,
                        AppAssets.splash_logo_light,
                        AppAssets.splash_logo_dark,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 100.0.autoSizeW,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _KakaoLoginButton(
                              isLoading: isLoading,
                              onTap: _login,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
