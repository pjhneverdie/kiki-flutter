import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';

import 'package:kiki/app/config/data/iconfig.dart';

@lazySingleton
class AESUtil {
  final Key _key;
  final IV _iv;
  final String _cipherAlgorithm;

  AESUtil(IConfig iConfig)
      : _key = Key.fromUtf8(iConfig.aesSecretKey),
        _iv = IV.fromUtf8(iConfig.aesIvSecretKey),
        _cipherAlgorithm = iConfig.cipherAlgorithm;

  String decrypt(String encryptedInput) {
    return Encrypter(
      AES(
        _key,
        mode: _toAESMode(_cipherAlgorithm.split("/")[0]),
        padding: _cipherAlgorithm.split("/")[1],
      ),
    ).decrypt64(
      encryptedInput,
      iv: _iv,
    );
  }

  AESMode _toAESMode(String mode) {
    return AESMode.values
        .where((value) => value.name.toUpperCase() == mode)
        .single;
  }
}
