part of 'package:kiki/app/walk_through/setting/view/account_view/screen/account_screen.dart';

class _AppBar extends StatelessWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 10.0.autoSizeW,
      ),
      height: 85.0.autoSizeH,
      color: useColorMode(
        context,
        Colors.orange,
        context.colors.middleBlack,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              color: Colors.transparent,
              child: Icon(
                Icons.chevron_left,
                size: 28.0.autoSizeSP,
                color: useColorMode(
                  context,
                  context.colors.strongBlack,
                  context.colors.weakGray,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 7.0.autoSizeW,
          ),
          Text(
            "계정 설정",
            style: TextStyle(
              color: useColorMode(
                context,
                context.colors.strongBlack,
                context.colors.weakGray,
              ),
              fontSize: 18.0.autoSizeSP,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

