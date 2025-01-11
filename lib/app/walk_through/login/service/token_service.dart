import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:kiki/app/config/data/iconfig.dart';
import 'package:kiki/app/walk_through/login/dto/Tokens.dart';
import 'package:kiki/common/util/aes_util.dart';

@lazySingleton
class TokenService {
  final AESUtil _aesUtil;
  final String _accessTokenKey;
  final String _refreshTokenKey;
  final FlutterSecureStorage _flutterSecureStorage;

  TokenService(
    IConfig iConfig,
    this._aesUtil,
    this._flutterSecureStorage,
  )   : _accessTokenKey = iConfig.accessTokenKey,
        _refreshTokenKey = iConfig.refreshTokenKey;

  Future<String?> getAccessToken() async {
    return await _flutterSecureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _flutterSecureStorage.read(key: _refreshTokenKey);
  }

  Future<void> saveTokens(Tokens tokens) async {
    /// 로그인 시 서버에서 엑세스, 리프레시 토큰을 "엑세스^리프레시"로 합치고 암호화해서 보내줌
    /// 그거 디코딩
    final String decryptedTokens = _aesUtil.decrypt(tokens.value!);
    final String accessToken = decryptedTokens.split(" ")[0];
    final String refreshToken = decryptedTokens.split(" ")[1];

    await _flutterSecureStorage.write(key: _accessTokenKey, value: accessToken);
    await _flutterSecureStorage.write(
        key: _refreshTokenKey, value: refreshToken);
  }

  Future<void> logout() async {
    await _flutterSecureStorage.delete(key: _accessTokenKey);
    await _flutterSecureStorage.delete(key: _refreshTokenKey);
  }
}
