part of 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

class _MobileWebUrlFormField extends StatelessWidget {
  final String _mobileWebUrl;

  const _MobileWebUrlFormField({
    required String mobileWebUrl,
  }) : _mobileWebUrl = mobileWebUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipPath(
          clipper: const ShapeBorderClipper(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0.autoSizeW,
            ),
            width: 50.0.autoSizeSP,
            height: 50.0.autoSizeSP,
            decoration: BoxDecoration(
              color: useColorMode(
                context,
                context.colors.blueGray,
                context.colors.weakBlack,
              ),
            ),
            child: Icon(
              Icons.link,
              size: 20.0.autoSizeSP,
              color: useColorMode(
                context,
                context.colors.strongBlack,
                context.colors.weakGray,
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: const ShapeBorderClipper(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0.autoSizeW,
            ),
            width: 200.0.autoSizeSP,
            height: 50.0.autoSizeSP,
            decoration: BoxDecoration(
              color: context.colors.strongWhite,
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _mobileWebUrl,
                      style: TextStyle(
                        color: context.colors.strongBlack,
                        fontSize: 13.0.autoSizeSP,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 8.0.autoSizeW,
                      ),
                    ),
                    const WidgetSpan(
                      child: _EditIcon(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
