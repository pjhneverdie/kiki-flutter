part of 'package:kiki/app/walk_through/login/view/terms_of_use_view/screen/terms_of_use_screen.dart';

class _AgreeButton extends StatefulWidget {
  const _AgreeButton({super.key});

  @override
  State<_AgreeButton> createState() => _AgreeButtonState();
}

class _AgreeButtonState extends State<_AgreeButton> {
  bool _isOnToast = false;
  bool _isPermitted = false;

  late final ChromeSafariBrowser _chromeSafariBrowser = TermsOfUseBrowser(
    onBrowserClosed: () async {
      setState(() {
        _isOnToast = true;
        _isPermitted = true;
      });

      ToastUtil.showAppDefaultToast(
        context,
        message: "서비스 이용약관에 동의하셨습니다, 더 이상 진행을 원치 않으실 시 앱을 종료해 주세요.",
      );

      await Future.delayed(const Duration(milliseconds: 3300));

      setState(() {
        _isOnToast = false;
      });
    },
  );

  void _onTap() {
    if (_isOnToast) {
    } else if (_isPermitted) {
      context.go(LoginScreen.PATH);
    } else {
      _chromeSafariBrowser.open(
        url: WebUri(getIt<IConfig>().termsOfUseUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ClipPath(
        clipper: const ShapeBorderClipper(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
        child: Container(
          height: 50.0.autoSizeH,
          color: context.colors.kakaoYellow,
          child: Center(
            child: _isOnToast
                ? const CircularProgressIndicator()
                : Text(
                    _isPermitted ? "다음" : "약관 조회 및 모두 동의",
                    style: TextStyle(
                      color: useColorMode(
                        context,
                        context.colors.strongBlack,
                        context.colors.middleBlack,
                      ),
                      fontSize: 15.0.autoSizeSP,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
