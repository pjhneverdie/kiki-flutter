part of 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

class _FeedFormAction extends StatelessWidget {
  final void Function()? _onActionTap;

  const _FeedFormAction({
    required void Function()? onActionTap,
  }) : _onActionTap = onActionTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _onActionTap,
          child: Padding(
            padding: EdgeInsets.all(
              15.0.autoSizeSP,
            ),
            child: Text(
              "수정",
              style: TextStyle(
                color: useColorMode(
                  context,
                  Colors.blue,
                  context.colors.weakGray,
                ),
                fontSize: 16.0.autoSizeSP,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
