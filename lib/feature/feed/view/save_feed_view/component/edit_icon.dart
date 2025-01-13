part of 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

class _EditIcon extends StatelessWidget {
  const _EditIcon();

  @override
  Widget build(BuildContext context) {
    return Icon(
      size: 15.0.autoSizeSP,
      Icons.create,
      color: context.colors.strongBlack,
    );
  }
}