import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:path/path.dart' as path;

import 'package:kiki/app/config/data/iconfig.dart';
import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/feature/feed/dto/feed_template_dto.dart';
import 'package:kiki/feature/feed/exception/feed_exception_code.dart';
import 'package:kiki/feature/feed/model/feed_template_model.dart';

@lazySingleton
class FeedCRUDService {
  final String _accessTokenKey;
  final String _refreshTokenKey;
  final FlutterSecureStorage _flutterSecureStorage;

  FeedCRUDService(
    IConfig iConfig,
    this._flutterSecureStorage,
  )   : _accessTokenKey = iConfig.accessTokenKey,
        _refreshTokenKey = iConfig.refreshTokenKey;

  /// validateExtension, 지원하는 파일인지 확인
  ///
  void _validateExtension(String filePath) {
    final String fileExtension = path.extension(filePath);
    final List<String> allowedExtensions = [".jpg", ".png", ".jpeg"];

    if (!allowedExtensions.contains(fileExtension)) {
      throw CustomException(exceptionCode: FeedExceptionCode.UN_SUPPORTED_FILE);
    }
  }

  /// compressImageFile, 파일 압축
  ///
  Future<File> _compressImageFile(File file) async {
    try {
      final String fileExtension = path.extension(file.path);
      final String outputPath =
          file.path.replaceAll(fileExtension, "_compressed$fileExtension");

      final XFile? compressedImage =
          await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outputPath,
        quality: 50,
      );

      return File(compressedImage!.path);
    } catch (e) {
      throw CustomException(
        exceptionCode: FeedExceptionCode.COMPRESSING_FAILED,
      );
    }
  }

  Future<void> saveFeed({
    required FeedTemplateDTO feedTemplateDTO,
  }) async {
    _validateExtension(feedTemplateDTO.imageFile.path);

    final File compressedImageFile =
        await _compressImageFile(feedTemplateDTO.imageFile);

    try {
      final ImageUploadResult imageUploadResult =
          await ShareClient.instance.uploadImage(image: compressedImageFile);

      final FeedTemplateModel feedTemplateModel = FeedTemplateModel(
        mobileWebUrl: feedTemplateDTO.mobileWebUrl,
        imageUrl: imageUploadResult.infos.original.url,
        imageTitle: feedTemplateDTO.imageTitle,
        buttonTitle: feedTemplateDTO.buttonTitle,
      );

      await _flutterSecureStorage.write(
        key: feedTemplateModel.imageUrl,
        value: jsonEncode(feedTemplateModel.toJson()),
      );
    } catch (e) {
      throw CustomException(exceptionCode: FeedExceptionCode.UPLOAD_FAILED);
    }
  }

  Future<void> updateFeed(FeedTemplateModel feedTemplateModel) async {
    await _flutterSecureStorage.write(
      key: feedTemplateModel.imageUrl,
      value: jsonEncode(feedTemplateModel.toJson()),
    );
  }

  Future<void> removeFeed(String imageUrl) async {
    await _flutterSecureStorage.delete(key: imageUrl);
  }

  Future<List<FeedTemplateModel>> readAllFeeds() async {
    final Map<String, String> feeds = await _flutterSecureStorage.readAll();

    /// 로컬스토리지에서 토큰만 빼고 다 불러오면 됨!
    feeds.removeWhere((key, value) {
      return key == _accessTokenKey || key == _refreshTokenKey;
    });

    List<FeedTemplateModel> feedTemplateModel = feeds.values.map((value) {
      return FeedTemplateModel.fromJson(jsonDecode(value));
    }).toList();

    return feedTemplateModel;
  }
}
