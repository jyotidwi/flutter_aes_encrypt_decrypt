import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';

class MyEncryptionDecryption {
  final String _aesKey = "buyaohuida-buyaohuida-buyaohuida";

  Future<String> decryptt({required String data}) async {
    final key = encrypt.Key.fromUtf8(_aesKey);
    final iv = encrypt.IV.fromBase64(data.substring(0, 24));
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.sic, padding: 'PKCS7'));
    final decrypted = encrypter.decrypt64(data.substring(24), iv: iv);
    if (kDebugMode) {
      print(decrypted);
    }
    return decrypted;
  }

  Future<String> encryptt({required String data}) async {
    final key = encrypt.Key.fromUtf8(_aesKey);
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.sic, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(data, iv: iv);
    if (kDebugMode) {
      print(encrypted);
    }
    return iv.base64 + encrypted.base64;
  }
}
