import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validus_coin/config/shared_pref_values.dart';
import 'package:validus_coin/config/strings.dart';
import 'package:validus_coin/config/style.dart';
import 'package:validus_coin/languages/en.dart';
import 'package:http/http.dart' as http;
import 'package:validus_coin/utils/db_manager.dart';
import 'package:validus_coin/utils/widgets/bottom_tab.dart';
import 'package:validus_coin/utils/widgets/custom_app_bar.dart';
import 'package:validus_coin/utils/widgets/loader.dart';
import 'package:validus_coin/utils/widgets/profile_attribute.dart';

import 'models/stock_model.dart';
import 'my_stock_item.dart';
class MyStocksWatchList extends StatefulWidget {
  const MyStocksWatchList({Key key}) : super(key: key);

  @override
  _MyStocksWatchListState createState() => _MyStocksWatchListState();
}

class _MyStocksWatchListState extends State<MyStocksWatchList>  with TickerProviderStateMixin {
  bool dataFetched = false;
  List<Stock> myStocks;
  TabController tabController;
  String name;
  String email;
  String address;
  bool fetchedSharedPref = false;
  @override
  void initState () {
    super.initState();
    fetchSharedPref();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      if (tabController.indexIsChanging) return;
      if ([0,1].contains(tabController.index)) {
        setState(() {});
      }
    });
    getData();
  }
  void fetchSharedPref () async{
    var prefs = await SharedPreferences.getInstance();
    SharedPref.name = prefs.getString(Strings.NAME);
    SharedPref.email = prefs.getString(Strings.EMAIL);
    SharedPref.address = prefs.getString(Strings.ADDRESS);
    setState(() {
      fetchedSharedPref = true;
    });
  }
  @override
  void dispose () {
    super.dispose();
    tabController?.dispose();
  }
  void getData () async {
    await DbManger().openDb(1);
    var resp = await http.get(Uri.parse(Strings.WATCH_LIST_API));
    var json = jsonDecode(resp.body);
    // RegExp('.{0,1023}').allMatches(json.toString()).forEach((element) => print('----- ${element.group(0)}'));
    myStocks = StockApi.fromJson(json).stocks;
    myStocks.forEach((element) {
      DbManger().insert([element.id, element.stockName, element.price.toString(), element.dayGain.toString(), element.lastTrade.toString(), element.extendedHours.toString(), element.lastPrice.toString()]);
    });
    List<Map> rows = await DbManger().getRows();
    for (int i = 0; i < rows.length; i++) {
      print ('---- row ${i+1}: ${rows[i].toString()}');
    }
    setState(() {
     dataFetched = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.watchListBgColor,
      body: SafeArea(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: dataFetched ? TabBarView (
                controller: tabController,
                children: [
                  myStocksWatchList(),
                  myProfile(),
                ],
              )
              : loader()
            ),
            BottomTab(tabController),
          ],
        ),
      ),
    );
  }
  Widget myStocksWatchList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(Lang.MY_WATCHLIST),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
            itemCount: myStocks.length,
            itemBuilder: (_, index) => MyStockItem (myStocks[index]),
            separatorBuilder: (_, index) => MyStockSeperator(),
          ),
        ),
      ],
    );
  }
  Widget myProfile() {
    return fetchedSharedPref ? Container (
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(Lang.PROFILE),
          ProfileAttribute(Strings.NAME, SharedPref.name),
          ProfileAttribute(Strings.EMAIL, SharedPref.email),
          ProfileAttribute(Strings.ADDRESS, SharedPref.address),
        ],
      ),
    )
    : loader();
  }
}

class MyStockSeperator extends StatelessWidget {
  const MyStockSeperator({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox (height: 16,);
  }
}

