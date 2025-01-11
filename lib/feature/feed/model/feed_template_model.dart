import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';

import 'package:kiki/common/util/base64_util.dart';

part 'feed_template_model.freezed.dart';

part 'feed_template_model.g.dart';

@Freezed(toJson: true)
class FeedTemplateModel with _$FeedTemplateModel {
  const factory FeedTemplateModel({
    required String imageUrl,
    required String imageTitle,
    required String buttonTitle,
    required String mobileWebUrl,
  }) = _FeedTemplateModel;

  factory FeedTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$FeedTemplateModelFromJson(json);
}

extension FeedTemplateExtension on FeedTemplateModel {
  FeedTemplate _toFeedTemplate(String baseUrl) {
    return FeedTemplate(
      content: Content(
        title: imageTitle,
        imageUrl: Uri.parse(imageUrl),
        link: Link(
          mobileWebUrl: Uri.parse(
            "$baseUrl/pay?mobileWebUrl=${Base64Util.encodeUrlSafeBase64(mobileWebUrl)}",
          ),
        ),
      ),
      buttons: [
        Button(
          title: buttonTitle,
          link: Link(
            mobileWebUrl: Uri.parse(
              "$baseUrl/pay?mobileWebUrl=${Base64Util.encodeUrlSafeBase64(mobileWebUrl)}",
            ),
          ),
        ),
      ],
    );
  }

  Future<void> share(String baseUrl) async {
    if (await ShareClient.instance.isKakaoTalkSharingAvailable()) {
      final Uri uri = await ShareClient.instance.shareDefault(
        template: _toFeedTemplate(baseUrl),
      );

      await ShareClient.instance.launchKakaoTalk(uri);
    }
  }
}
