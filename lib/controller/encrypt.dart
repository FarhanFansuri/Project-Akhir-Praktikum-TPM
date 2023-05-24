import "package:encrypt/encrypt.dart";

class EncriptLogin {
  static encrypt(data) {
    final key = Key.fromLength(32);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(data, iv: iv);

    return encrypted.base64;
  }
}