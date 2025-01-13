part of 'package:kiki/app/walk_through/home/view/home_view/screen/home_screen.dart';

class _Options extends StatelessWidget {
  final void Function() _onSettingTap;

  final void Function() _onMyTap;

  final void Function() _onTemplateTap;

  const _Options({
    required void Function() onSettingTap,
    required void Function() onMyTap,
    required void Function() onTemplateTap,
  })  : _onSettingTap = onSettingTap,
        _onMyTap = onMyTap,
        _onTemplateTap = onTemplateTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // GestureDetector(
        //   onTap: _onSettingTap,
        //   child: const _OptionCard(
        //     option: "앱 설정",
        //     iconData: Icons.settings,
        //   ),
        // ),
        SizedBox(
          width: 10.0.autoSizeW,
        ),
        GestureDetector(
          onTap: _onMyTap,
          child: const _OptionCard(
            option: "MY",
            iconData: Icons.person,
          ),
        ),
        SizedBox(
          width: 10.0.autoSizeW,
        ),
        GestureDetector(
          onTap: _onTemplateTap,
          child: const _OptionCard(
            option: "템플릿",
            iconData: Icons.create_rounded,
          ),
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String _option;
  final IconData _iconData;

  const _OptionCard({
    required String option,
    required IconData iconData,
  })  : _iconData = iconData,
        _option = option;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0.autoSizeW,
          vertical: 10.0.autoSizeH,
        ),
        decoration: BoxDecoration(
          color: useColorMode(
            context,
            Colors.blue,
            context.colors.weakBlack,
          ),
        ),
        child: Row(
          children: [
            Text(
              _option,
              style: TextStyle(
                color: useColorMode(
                  context,
                  context.colors.strongWhite,
                  context.colors.weakGray,
                ),
                fontSize: 14.0.autoSizeSP,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 7.5.autoSizeW,
            ),
            Icon(
              _iconData,
              color: useColorMode(
                context,
                context.colors.strongWhite,
                context.colors.weakGray,
              ),
              size: 20.0.autoSizeSP,
            ),
          ],
        ),
      ),
    );
  }
}
