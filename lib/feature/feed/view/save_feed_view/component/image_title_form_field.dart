part of 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

class _ImageTitleFormField extends StatelessWidget {
  final String _imageTitle;

  const _ImageTitleFormField({
    required String imageTitle,
  }) : _imageTitle = imageTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          _imageTitle,
          style: TextStyle(
            color: context.colors.strongBlack,
            fontSize: 12.0.autoSizeSP,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          width: 8.0.autoSizeW,
        ),
        const _EditIcon(),
      ],
    );
  }
}
