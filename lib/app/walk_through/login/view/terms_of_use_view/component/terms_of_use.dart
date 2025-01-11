part of 'package:kiki/app/walk_through/login/view/terms_of_use_view/screen/terms_of_use_screen.dart';

class _TermsOfUse extends StatelessWidget {
  const _TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              width: 30.0.autoSizeSP,
              height: 30.0.autoSizeSP,
              useColorMode(
                context,
                AppAssets.kiki_logo_align_left_light,
                AppAssets.kiki_logo_align_left_dark,
              ),
            ),
            Text(
              "kiki 서비스 이용약관",
              style: TextStyle(
                color: useColorMode(
                  context,
                  context.colors.strongBlack,
                  context.colors.strongWhite,
                ),
                fontSize: 15.0.autoSizeSP,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.0.autoSizeH,
        ),
        const _Term(
          content: "(필수) 만 14세 이상 서비스 이용 동의",
        ),
        SizedBox(
          height: 8.0.autoSizeH,
        ),
        const _Term(
          content: "(필수) 만 14세 이상 서비스 이용 동의",
        ),
      ],
    );
  }
}

class _Term extends StatelessWidget {
  final String _content;

  const _Term({super.key, required String content}) : _content = content;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _content,
            style: TextStyle(
              color: useColorMode(
                context,
                context.colors.strongBlack,
                context.colors.strongWhite,
              ),
              fontSize: 14.0.autoSizeSP,
            ),
          ),
          Container(
            height: 1.0.autoSizeH,
            color: useColorMode(
              context,
              context.colors.strongBlack,
              context.colors.strongWhite,
            ),
          ),
        ],
      ),
    );
  }
}
