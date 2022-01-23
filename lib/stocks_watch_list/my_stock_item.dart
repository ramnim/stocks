
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/stock_model.dart';
import 'package:intl/intl.dart';
import 'dart:math';
class MyStockItem extends StatefulWidget {
  final Stock stock;
  const MyStockItem(this.stock, {Key key}) : super(key: key);

  @override
  _MyStockItemState createState() => _MyStockItemState();
}

class _MyStockItemState extends State<MyStockItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration (
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color(0xFF1E1E3D),
      ),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(),
          stockAttribute('Price', widget.stock.price),
          stockAttribute('Day gain', widget.stock.dayGain),
          stockAttribute('Last trade', widget.stock.lastTrade),
          stockAttribute('Extended hrs', widget.stock.extendedHours),
          stockAttributeChangeIndicator('% Change', widget.stock.dayGain * 100 / widget.stock.price,),
        ],
      ),
    );
  }
  Widget title () {
    return Container (
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: Text(widget.stock.stockName ?? '', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
    );
  }
  Widget stockAttribute (String name, dynamic value) {
    String valueString;
    if (value == null) valueString = '';
    if (value is int) valueString = value.toString();
    else if (value is double) valueString = value.toStringAsFixed(2);
    // else if (value is DateTime) valueString = DateFormat.yMMMd().format(value);
    else if (value is DateTime) valueString = DateFormat.jm().format(value);
    return Container (
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: Container(
        child: Row (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: TextStyle(height: 0.5, fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFFD2D2D2)),),
            Text(valueString, style: TextStyle(height: 0.5, fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),),
          ],
        ),
      ),
    );
  }
  Widget stockAttributeChangeIndicator (String name, dynamic value) {
    String valueString;
    if (value == null) valueString = '';
    if (value is int) valueString = value.toString();
    else if (value is double) valueString = value.toStringAsFixed(2);
    // else if (value is double) valueString = (value * -1).toStringAsFixed(2);
    else if (value is DateTime) valueString = DateFormat.yMMMd().format(value);
    bool isGain = !valueString.startsWith('-');
    return Container (
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(height: 0.5, fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFFD2D2D2)),),
          Row(
            children: [
              isGain ? iconUp() : iconDown(),
              Text(valueString + '%', style: TextStyle(height: 0.5, fontSize: 18, fontWeight: FontWeight.w400, color: isGain ? Color(0xFF1ACC81) : Color(0xFFE22716)),),
            ],
          ),
        ],
      ),
    );
  }
  Widget iconUp () {
    return Row(
      children: [
        Transform.rotate (
          angle: 270 * pi / 180,
          child: Icon(
            Icons.play_arrow_rounded,
            size: 20.0, color: Color(0xFF1ACC81),
          ),
        ),
        Text('+', style: TextStyle(height: 0.5, fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFF1ACC81)),),
      ],
    );
  }
  Widget iconDown () {
    return Row(
      children: [
        Transform.rotate (
          angle: 90 * pi / 180,
          child: Icon(
            Icons.play_arrow_rounded,
            size: 20.0, color: Color(0xFFE22716),
          ),
        ),
        Text('-', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFFE22716)),)
      ],
    );
  }
}
