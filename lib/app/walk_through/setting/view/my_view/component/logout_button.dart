part of 'package:kiki/app/walk_through/setting/view/my_view/screen/my_screen.dart';

class _LogoutButton extends StatelessWidget {
  final void Function() _onTap;

  const _LogoutButton({
    required void Function() onTap,
  }) : _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.autoSizeW,
          vertical: 16.0.autoSizeH,
        ),
        color: useColorMode(
          context,
          context.colors.strongWhite,
          context.colors.weakGray,
        ),
        child: Text(
          "로그아웃",
          style: TextStyle(
            color: useColorMode(
              context,
              context.colors.strongBlack,
              context.colors.strongBlack,
            ),
            fontSize: 12.0.autoSizeSP,
          ),
        ),
      ),
    );
  }
}
