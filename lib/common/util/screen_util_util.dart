import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilUtil {
  static void screenUtilPortraitInit(BuildContext context) {
    ScreenUtil.init(
      context,
      minTextAdapt: true,
      designSize: const Size(360, 690),
    );
  }

  static void screenUtilLandscapeInit(BuildContext context) {
    ScreenUtil.init(
      context,
      minTextAdapt: true,
      designSize: const Size(690, 360),
    );
  }
}

extension AutoSizeExtension on double {
  double get autoSizeH {
    return math.min(this.h, this * 1.5);
  }

  double get autoSizeW {
    return math.min(this.w, this * 1.5);
  }

  double get autoSizeSP {
    return math.min(this.sp, this * 1.5);
  }
}
