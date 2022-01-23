import 'package:flutter/material.dart';

Widget loader() {
  return Stack(
    children: [
      Align(alignment: Alignment.center, child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.red))),
    ],
  );
}