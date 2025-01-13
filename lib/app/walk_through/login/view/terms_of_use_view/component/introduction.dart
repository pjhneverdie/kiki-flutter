part of 'package:kiki/app/walk_through/login/view/terms_of_use_view/screen/terms_of_use_screen.dart';

class _Introduction extends StatelessWidget {
  const _Introduction();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "서비스 이용을 위해\n약관에 동의해 주세요.",
          style: TextStyle(
            color: useColorMode(
              context,
              context.colors.strongBlack,
              context.colors.weakGray,
            ),
            fontSize: 22.0.autoSizeSP,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16.0.autoSizeH,
        ),
        Text(
          "kiki가 제공하는 아래 서비스를 계속 이용\n하시려면 약관에 동의가 필요합니다.",
          style: TextStyle(
            fontSize: 16.0.autoSizeSP,
            color: useColorMode(
              context,
              context.colors.strongGray,
              context.colors.weakGray,
            ),
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 10.0.autoSizeH,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.circle_fill,
              size: 6.0.autoSizeSP,
              color: useColorMode(
                context,
                context.colors.strongGray,
                context.colors.weakGray,
              ),
            ),
            SizedBox(
              width: 10.0.autoSizeW,
            ),
            Text(
              "카카오톡 공유하기 kiki전용 템플릿 이용",
              style: TextStyle(
                color: useColorMode(
                  context,
                  context.colors.strongGray,
                  context.colors.weakGray,
                ),
                fontSize: 13.0.autoSizeSP,
              ),
            ),
          ],
        ),
      ],
    );
  }
}