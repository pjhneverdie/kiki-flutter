part of 'package:kiki/app/walk_through/home/view/home_view/screen/home_screen.dart';

class _FAB extends StatelessWidget {
  final Future<void> Function() _onPressed;

  const _FAB({
    super.key,
    required Future<void> Function() onPressed,
  }) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.0.autoSizeSP,
      height: 60.0.autoSizeSP,
      child: FloatingActionButton(
        elevation: 0,
        onPressed: _onPressed,
        backgroundColor: useColorMode(
          context,
          Colors.orange,
          context.colors.kakaoYellow,
        ),
        foregroundColor: useColorMode(
          context,
          context.colors.strongBlack,
          context.colors.weakGray,
        ),
        child: Icon(
          Icons.share,
          size: 30.0.autoSizeSP,
          color: useColorMode(
            context,
            context.colors.strongWhite,
            context.colors.strongBlack,
          ),
        ),
      ),
    );
  }
}
