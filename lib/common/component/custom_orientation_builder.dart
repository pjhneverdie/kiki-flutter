import 'package:flutter/material.dart';
import 'package:kiki/common/util/screen_util_util.dart';

class CustomOrientationBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) portraitBuilder;
  final Widget Function(BuildContext context) landscapeBuilder;

  const CustomOrientationBuilder({
    super.key,
    required this.portraitBuilder,
    required this.landscapeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          ScreenUtilUtil.screenUtilPortraitInit(context);
          return portraitBuilder(context);
        } else {
          ScreenUtilUtil.screenUtilLandscapeInit(context);
          return landscapeBuilder(context);
        }
      },
    );
  }
}
