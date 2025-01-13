part of 'package:kiki/app/walk_through/setting/view/my_view/screen/my_screen.dart';


class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0.autoSizeH,
      color: useColorMode(
        context,
        context.colors.weakGray,
        context.colors.strongBlack,
      ),
    );
  }
}
