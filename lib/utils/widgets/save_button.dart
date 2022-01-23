import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final Color fillColor;
  final Function callBackFn;
  const SaveButton(this.text, this.callBackFn, {this.fillColor = const Color(0xFFFFC700), Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration (
          color: fillColor,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Center(child: Text (text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black)),),
      ),
      onTap: callBackFn,
    );
  }
}
