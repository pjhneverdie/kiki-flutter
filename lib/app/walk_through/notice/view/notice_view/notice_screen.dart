import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/common/component/custom_orientation_builder.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';

class NoticeScreen extends StatefulWidget {
  static const String PATH = "/notice";

  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: useColorMode(
        context,
        context.colors.strongWhite,
        context.colors.strongBlack,
      ),
      body: SafeArea(
        child: Center(
          child: CustomOrientationBuilder(
            portraitBuilder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(
                    height: 10.0.autoSizeH,
                  ),
                  Text(
                    "서버 점검 중입니다. 나중에 다시 접속해 주세요.",
                    style: TextStyle(
                      color: useColorMode(
                        context,
                        context.colors.strongBlack,
                        context.colors.weakGray,
                      ),
                    ),
                  ),
                ],
              );
            },
            landscapeBuilder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(
                    height: 10.0.autoSizeH,
                  ),
                  Text(
                    "서버 점검 중입니다. 나중에 다시 접속해 주세요.",
                    style: TextStyle(
                      color: useColorMode(
                        context,
                        context.colors.strongBlack,
                        context.colors.weakGray,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
