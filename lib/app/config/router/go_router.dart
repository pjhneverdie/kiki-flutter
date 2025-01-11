import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:kiki/app/walk_through/home/view/home_view/screen/home_screen.dart';
import 'package:kiki/app/walk_through/login/dto/Tokens.dart';
import 'package:kiki/app/walk_through/login/view/login_view/screen/login_screen.dart';
import 'package:kiki/app/walk_through/login/view/terms_of_use_view/screen/terms_of_use_screen.dart';
import 'package:kiki/app/walk_through/notice/view/notice_view/notice_screen.dart';
import 'package:kiki/app/walk_through/setting/view/account_view/screen/account_screen.dart';
import 'package:kiki/app/walk_through/setting/view/my_view/screen/my_screen.dart';
import 'package:kiki/app/walk_through/setting/view/setting_view/screen/setting_screen.dart';
import 'package:kiki/common/util/base64_util.dart';
import 'package:kiki/feature/feed/model/feed_template_model.dart';
import 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

@module
abstract class GoRouterModule {
  @lazySingleton
  GoRouter goRouter(CurrentLocationTracker tracker) {
    return GoRouter(
        initialLocation: TermsOfUseScreen.PATH,
        observers: [
          tracker,
        ],
        routes: [
          /// 개인정보 처리방침 동의 화면
          ///
          GoRoute(
            path: TermsOfUseScreen.PATH,
            builder: (context, state) {
              return const TermsOfUseScreen();
            },
          ),

          /// 로그인 화면 앱
          ///
          GoRoute(
            path: LoginScreen.PATH,
            builder: (context, state) {
              return const LoginScreen(tokens: null);
            },
          ),

          /// 로그인 화면 웹 -> 앱 딥링킹
          ///
          GoRoute(
            path: LoginScreen.DEEP_LINK_PATH,
            builder: (context, state) {
              /// 토큰이 암호화 돼서 들어옴
              String? base64 = state.uri.queryParameters["tokens"];

              /// url-safe base64 -> base64
              if (base64 != null) {
                base64 = Base64Util.normalizeBase64(base64);
              }

              return LoginScreen(
                tokens: Tokens(base64),
              );
            },
          ),

          /// 홈 화면
          ///
          GoRoute(
            path: HomeScreen.PATH,
            builder: (context, state) => const HomeScreen(),
            routes: [
              /// 설정 화면
              ///
              GoRoute(
                path: SettingScreen.PATH,
                builder: (context, state) => const SettingScreen(),
              ),

              /// 마이 페이지
              ///
              GoRoute(
                path: MyScreen.PATH,
                builder: (context, state) => const MyScreen(),
                routes: [
                  /// 계정 설정 화면
                  ///
                  GoRoute(
                    path: AccountScreen.PATH,
                    builder: (context, state) => const AccountScreen(),
                  ),
                ],
              ),

              /// 템플릿 생성 화면
              ///
              GoRoute(
                path: SaveFeedScreen.PATH,
                builder: (context, state) {
                  final String? jsonFeedTemplateModel =
                      state.uri.queryParameters["feedTemplateModel"];

                  final FeedTemplateModel? feedTemplateModel =
                      jsonFeedTemplateModel != null
                          ? FeedTemplateModel.fromJson(
                              jsonDecode(jsonFeedTemplateModel),
                            )
                          : null;

                  return SaveFeedScreen(
                    feedTemplateModel: feedTemplateModel,
                  );
                },
              ),
            ],
          ),

          /// 서비스 공지 화면
          ///
          GoRoute(
            path: NoticeScreen.PATH,
            builder: (context, state) => const NoticeScreen(),
          ),
        ],
        redirect: (context, state) async {
          /// 카카오톡 -> 앱 딥링킹 리다이렉트
          ///
          if (state.uri.toString().startsWith("kakao")) {
            return tracker.currentLocation;
          } else {
            return null;
          }
        });
  }
}

@lazySingleton
class CurrentLocationTracker extends NavigatorObserver {
  String _currentLocation = "/";

  String get currentLocation => _currentLocation;

  set currentLocation(String location) {
    _currentLocation = location;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      currentLocation = route.settings.name!;
    }

    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute?.settings.name != null) {
      currentLocation = previousRoute!.settings.name!;
    }

    super.didPop(route, previousRoute);
  }
}
