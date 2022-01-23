
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:validus_coin/config/strings.dart';

final key = Key.fromUtf8(Strings.PASSWORD_KEY);
final iv = IV.fromLength(16);
final encrypter = Encrypter(AES(key));

class SharedPref {
  static String name;
  static String email;
  static String address;
}
void updateSharedPref(String name, String value) {
  switch (name) {
    case Strings.NAME:
      SharedPref.name = value;
      break;
    case Strings.EMAIL:
      SharedPref.email = value;
      break;
    case Strings.ADDRESS:
      SharedPref.address = value;
      break;
    default:
  }
}
String getSharedPref(String name) {
  switch (name) {
    case Strings.NAME:
      return SharedPref.name;
    case Strings.EMAIL:
      return SharedPref.email;
    case Strings.ADDRESS:
      return SharedPref.address;
    default:
      return '';
  }
}
String encryptStr(String value) {
  if (value == null) return '';
  var encrypted = encrypter.encrypt(value, iv: iv);
  var uint8list = encrypted.bytes;
  String encryptedStr = String.fromCharCodes(uint8list);
  return encryptedStr;
}
String decryptStr(String encryptedStr) {
  if (encryptedStr == null) return '';
  var uint8list = Uint8List.fromList(encryptedStr.codeUnits);
  var deString = encrypter.decrypt(Encrypted(uint8list), iv: iv);
  return deString;
}
