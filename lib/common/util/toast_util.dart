import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/common/util/screen_util_util.dart';

class ToastUtil {
  static void toast({
    required String msg,
    required int timeInSecForIosWeb,
    required Color backgroundColor,
    required double fontSize,
    required Color textColor,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      timeInSecForIosWeb: timeInSecForIosWeb,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      textColor: textColor,
    );
  }

  static void showAppDefaultToast(
    BuildContext context, {
    required String message,
  }) {
    toast(
      msg: message,
      timeInSecForIosWeb: 3,
      backgroundColor: context.colors.strongBlack.withOpacity(0.75),
      fontSize: 15.0.autoSizeSP,
      textColor: context.colors.kakaoYellow,
    );
  }
}
