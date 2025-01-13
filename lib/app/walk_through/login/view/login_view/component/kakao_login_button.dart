part of 'package:kiki/app/walk_through/login/view/login_view/screen/login_screen.dart';

class _KakaoLoginButton extends StatefulWidget {
  final bool _isLoading;
  final void Function() _onTap;

  const _KakaoLoginButton({
    required bool isLoading,
    required void Function() onTap,
  })  : _onTap = onTap,
        _isLoading = isLoading;

  @override
  State<_KakaoLoginButton> createState() => _KakaoLoginButtonState();
}

class _KakaoLoginButtonState extends State<_KakaoLoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget._onTap,
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
            child: widget._isLoading
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.kakao_logo,
                        width: 20.0.autoSizeSP,
                      ),
                      SizedBox(
                        width: 10.0.autoSizeW,
                      ),
                      Text(
                        "카카오 로그인",
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
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
