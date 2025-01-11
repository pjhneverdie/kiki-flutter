part of 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

class _Guide extends StatelessWidget {
  final Future<void> Function() _onSaveButtonTap;
  final Future<void> Function() _onRemoveButtonTap;

  const _Guide({
    required Future<void> Function() onSaveButtonTap,
    required Future<void> Function() onRemoveButtonTap,
  })  : _onRemoveButtonTap = onRemoveButtonTap,
        _onSaveButtonTap = onSaveButtonTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0.autoSizeH,
      color: useColorMode(
        context,
        context.colors.strongWhite,
        context.colors.weakBlack,
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "템플릿이 마음에 드시나요?",
                style: TextStyle(
                  color: useColorMode(
                    context,
                    context.colors.strongBlack,
                    context.colors.weakGray,
                  ),
                  fontSize: 12.0.autoSizeSP,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const TextSpan(
                text: "    ",
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: _onSaveButtonTap,
                  child: Text(
                    "저장",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12.0.autoSizeSP,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const TextSpan(
                text: "    ",
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: _onRemoveButtonTap,
                  child: Text(
                    "삭제",
                    style: TextStyle(
                      color: useColorMode(
                        context,
                        context.colors.weakBlack,
                        context.colors.strongGray,
                      ),
                      fontSize: 12.0.autoSizeSP,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
