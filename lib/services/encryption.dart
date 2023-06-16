import 'package:encrypt/encrypt.dart' as encrypt;

class MyEncryption {
  static encryptAES(text) async {
    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    // final decrypted = encrypter.decrypt(password, iv: iv);
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted;
  }
}
