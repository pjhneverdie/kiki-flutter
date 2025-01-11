part of 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

class _ImageFormField extends StatelessWidget {
  final String? _imageUrl;
  final File? _imageFile;

  const _ImageFormField({
    required String? imageUrl,
    required File? imageFile,
  })  : _imageFile = imageFile,
        _imageUrl = imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Container(
        width: 250.0.autoSizeSP,
        height: 250.0.autoSizeSP,
        color: useColorMode(
          context,
          context.colors.blueGray,
          context.colors.weakBlack,
        ),
        child: _imageFile == null && _imageUrl == null
            ? Icon(
                CupertinoIcons.photo,
                size: 20.0.autoSizeSP,
                color: useColorMode(
                  context,
                  context.colors.strongBlack,
                  context.colors.weakGray,
                ),
              )
            : _imageFile != null
                ? Image.file(
                    fit: BoxFit.cover,
                    File(_imageFile!.path),
                  )
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: _imageUrl!,
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Center(
                        child: Text(
                          "템플릿 저장 기한이 만료됐습니다.",
                          style: TextStyle(
                            color: useColorMode(
                              context,
                              context.colors.strongBlack,
                              context.colors.weakGray,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
