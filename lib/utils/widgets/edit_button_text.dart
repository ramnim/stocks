import 'package:flutter/material.dart';
import 'package:validus_coin/config/style.dart';

class EditButtonText extends StatelessWidget {
  final String text;
  final Function callBackFn;
  const EditButtonText(this.text, this.callBackFn, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration (
          border: Border(bottom: BorderSide(color: Colors.white)),
        ),
        child: Text (text, style: Style.editText,),
      ),
      onTap: callBackFn,
    );
  }
}
