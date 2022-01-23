
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final bool closeButton;
  const CustomAppBar(this.title, {this.closeButton = false, Key key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return widget.closeButton ? Container (
      padding: EdgeInsets.only(left: 16, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Icon(Icons.close, size: 30, color: Colors.white,),
            onTap: () => Navigator.of(context).pop(),
          ),
          Text (widget.title ?? '', style: TextStyle(color: Colors.white, fontSize: 36,),),
          Icon(Icons.close, size: 20, color: Colors.transparent,),
        ],
      ),
    )
    : Container (
      padding: EdgeInsets.only(left: 16, bottom: 24),
      child: Text (widget.title ?? '', style: TextStyle(color: Colors.white, fontSize: 36,),),
    );
  }
}
