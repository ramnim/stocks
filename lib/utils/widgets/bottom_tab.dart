import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomTab extends StatefulWidget {
  final TabController tabController;
  const BottomTab(this.tabController, {Key key}) : super(key: key);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  TabController tabController;
  @override
  void initState () {
    super.initState();
    tabController = widget.tabController;
  }
  @override
  Widget build (BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        // indicatorColor: Colors.transparent,
        tabs: [
          tabItemStocks('Stocks', 'assets/svg/stock_chart_icon.svg', 0),
          tabItemProfile('Profile', 'assets/svg/home_icon.svg', 1),
        ],
      ),
    );
  }
  Widget tabItemStocks (String name, String assetPah, int index) {
    return GestureDetector(
      child: Container (
        key: UniqueKey(),
        padding: EdgeInsets.symmetric(vertical: 20,),
        child: Column (
          children: [
            // SvgPicture.asset(assetPah, width: 25, height: 20, color: currentIndex == index ? Color(0xFFFFB802) : Color(0xFFA2A2AE)),
            SvgPicture.asset(assetPah, color: tabController.index == index ? Color(0xFFFFB802) : Color(0xFFA2A2AE)),
            SizedBox(height: 6,),
            Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: tabController.index == index ? Color(0xFFFFB802) : Color(0xFFA2A2AE)),)
          ],
        ),
      ),
      onTap: () {
        setState(() {tabController.index = index;});
      },
    );
  }
  Widget tabItemProfile (String name, String assetPah, int index) {
    return GestureDetector(
      child: Container (
        key: UniqueKey(),
        padding: EdgeInsets.symmetric(vertical: 20,),
        child: Column (
          children: [
            // SvgPicture.asset(assetPah, width: 25, height: 20, color: currentIndex == index ? Color(0xFFFFB802) : Color(0xFFA2A2AE)),
            SvgPicture.asset(assetPah, color: tabController.index == index ? Color(0xFFFFB802) : Color(0xFFA2A2AE)),
            SizedBox(height: 6,),
            Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: tabController.index == index ? Color(0xFFFFB802) : Color(0xFFA2A2AE)),)
          ],
        ),
      ),
      onTap: () {
        setState(() {tabController.index = index;});
      },
    );
  }
}
