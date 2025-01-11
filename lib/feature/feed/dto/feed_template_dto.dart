import 'dart:io';

class FeedTemplateDTO {
  String mobileWebUrl;
  File imageFile;
  String imageTitle;
  String buttonTitle;

  FeedTemplateDTO({
    required this.mobileWebUrl,
    required this.imageFile,
    required this.imageTitle,
    required this.buttonTitle,
  });
}
