part of 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

class _ButtonTitleForm extends StatelessWidget {
  final String _buttonTitle;

  const _ButtonTitleForm({
    required String buttonTitle,
  }) : _buttonTitle = buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0.autoSizeSP,
      height: 40.0.autoSizeSP,
      decoration: BoxDecoration(
        color: useColorMode(
          context,
          context.colors.kakaoYellow,
          context.colors.weakGray.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _buttonTitle,
            style: TextStyle(
              color: context.colors.strongBlack,
              fontSize: 14.0.autoSizeSP,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: 8.0.autoSizeW,
          ),
          const _EditIcon(),
        ],
      ),
    );
  }
}
