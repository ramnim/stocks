import 'package:validus_coin/config/shared_pref_values.dart';
import 'package:validus_coin/config/strings.dart';
import 'package:validus_coin/languages/en.dart';
import 'package:encrypt/encrypt.dart';
double getDoubleFrom(dynamic val,{bool returnNullIfNull = false}) {
  if(returnNullIfNull && val == null)return val;
  if (val is double) return val;
  if (val is String) {
    try {
      return double.parse(val);
    } catch (e) {
      return 0.0;
    }
  }
  if (val is int) return val.toDouble();
  if (val is bool) return val ? 1.0 : 0.0;
  return 0.0;
}
int getIntFrom(dynamic val,{bool returnNullIfNull = false}) {
  if(returnNullIfNull && val == null)return val;
  if (val is int) return val;
  if (val is String) {
    try {
      return int.parse(val);
    } catch (e) {
      return 0;
    }
  }
  if (val is double) return val.toInt();
  if (val is bool) return val ? 1 : 0;
  return 0;
}
bool getBoolFrom(dynamic val,{bool returnNullIfNull = false}) {
  if(returnNullIfNull && val == null)return val;
  if (val is bool) return val;
  if (val is String) {
    try {
      return val == "Y";
    } catch (e) {
      return false;
    }
  }
  if (val is int) return val == 1;
  if (val is double) return val == 1.0;
  return false;
}
DateTime getDateTimeFrom(dynamic val,{bool returnNullIfNull = false}) {
  if(returnNullIfNull && val == null)return val;
  try {
    if (val is DateTime)
      return val;
    else if (val is String) {
      return DateTime.parse(val);
    } else if (val is int) {
      return DateTime.fromMicrosecondsSinceEpoch(val);
    } else if (val is double) {
      return DateTime.fromMicrosecondsSinceEpoch(val.toInt());
    }
  } catch (e) {}
  return DateTime.now();
}
String getText(String name) {
  String retText;
  switch (name) {
    case Strings.NAME:
      retText = Lang.NAME;
      break;
    case Strings.EMAIL:
      retText = Lang.EMAIL;
      break;
    case Strings.ADDRESS:
      retText = Lang.ADDRESS;
      break;
    default:
      retText = '';
  }
  return retText;
}
String encryptData(String str) {
  final encrypted = encrypter.encrypt(str, iv: iv);
}
bool isEmail(String em) {
  String emailRegexp =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(emailRegexp);
  return regExp.hasMatch(em);
}
