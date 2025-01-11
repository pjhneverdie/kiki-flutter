import 'package:flutter/material.dart';
import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';

class FeedCard extends StatelessWidget {
  final Widget _image;

  const FeedCard({
    super.key,
    required Widget image,
  }) : _image = image;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(60),
          ),
        ),
      ),
      child: Container(
        width: 250.0.autoSizeSP,
        height: 250.0.autoSizeSP,
        color: useColorMode(
          context,
          context.colors.strongWhite,
          context.colors.weakBlack,
        ),
        child: _image,
      ),
    );
  }
}
