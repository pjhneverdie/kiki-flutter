import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';

import 'package:kiki/app/config/data/iconfig.dart';
import 'package:kiki/app/di/custom_profile.dart';

@localhost
@Singleton(as: IConfig)
class AppDataLocalhost implements IConfig {
  @override
  String get kakaoNativeAppKey => "6f2a42b843e2024329ca69685d2e5258";

  @PostConstruct()
  void init() {
    KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);
  }

  @override
  String get baseUrl => "https://swift-willing-panda.ngrok-free.app";

  @override
  String get termsOfUseUrl =>
      "https://plip.kr/pcc/0356e3c3-5bb4-467a-8f16-dbfe0c7bc159/privacy-policy";

  @override
  String get kakaoLoginUrl => "$baseUrl/oauth2/authorization/kakao";

  @override
  String get aesSecretKey => "local-secret-key";

  @override
  String get aesIvSecretKey => "local-secret-key";

  @override
  String get cipherAlgorithm => "CBC/PKCS7";

  @override
  String get accessTokenKey => "accessTokenKey";

  @override
  String get refreshTokenKey => "refreshTokenKey";
}
