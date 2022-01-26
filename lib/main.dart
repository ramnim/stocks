import 'package:flutter/material.dart';
import 'package:validus_coin/stocks_watch_list/my_stocks_watch_list.dart';

import 'languages/en.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Lang.VALIDUS_COIN,
      home: MyStocksWatchList(),
    );
  }
}