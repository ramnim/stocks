import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validus_coin/config/shared_pref_values.dart';
import 'package:validus_coin/config/strings.dart';
import 'package:validus_coin/config/style.dart';
import 'package:validus_coin/languages/en.dart';

import '../utility_functions.dart';
import 'edit_button_text.dart';
import 'edit_text_field.dart';

class ProfileAttribute extends StatefulWidget {
  final String attribute;
  final String value;
  const ProfileAttribute(this.attribute, this.value, {Key key}) : super(key: key);

  @override
  _ProfileAttributeState createState() => _ProfileAttributeState();
}

class _ProfileAttributeState extends State<ProfileAttribute> {
  String value;
  SharedPreferences prefs;
  @override
  void initState () {
    SharedPreferences.getInstance().then((value) => prefs = value);
    value = widget.value;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 27),
      color: Style.profileAttributeBgColor,
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          attributeHeader(),
          SizedBox(height: 15,),
          attributeValue(value),
        ],
      ),
    );
  }
  Widget attributeValue (String value) {
    return Text(decryptStr(value), style: Style.profileAttributeValue,);
  }
  Widget attributeHeader () {
    return Container (
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text (getText(widget.attribute), style: Style.profileAttributeName,),
          EditButtonText(Lang.EDIT, onEditAttribute),
        ],
      ),
    );
  }
  void onEditAttribute () {
    Navigator.of(context).push(PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => EditTextFiled(widget.attribute, value, desc: Lang.NAME_EDIT_DESC))).then((newValue) async {
      setState(() {value = getSharedPref(widget.attribute);});
    });
  }
}
