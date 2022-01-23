import 'package:flutter/material.dart';
import 'package:validus_coin/config/shared_pref_values.dart';
import 'package:validus_coin/config/strings.dart';
import 'package:validus_coin/config/style.dart';
import 'package:validus_coin/languages/en.dart';
import 'package:validus_coin/utils/utility_functions.dart';
import 'package:validus_coin/utils/widgets/custom_app_bar.dart';
import 'package:validus_coin/utils/widgets/save_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditTextFiled extends StatefulWidget {
  final String name;
  final String value;
  final String desc;
  const EditTextFiled(this.name, this.value, {this.desc, Key key}) : super(key: key);

  @override
  _EditTextFiledState createState() => _EditTextFiledState();
}

class _EditTextFiledState extends State<EditTextFiled> {
  TextEditingController controller;
  String value;
  @override
  void initState () {
    super.initState();
    value = widget.value;
    controller = TextEditingController(text: decryptStr(value));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30,),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration (
                  color: Style.profileBgColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 24,),
                    CustomAppBar(Lang.EDIT + ' ' + widget.name, closeButton: true,),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration (
                        color: Style.textFieldColor,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text (widget.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFA1A1A1)),),
                          TextField (
                            controller: controller,
                            style: Style.editText,
                            decoration: InputDecoration (
                              hintText: getText(widget.name),
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SaveButton(Lang.SAVE, onSaveClicked),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void onSaveClicked () {
    value = controller.text.trim();
    if (value == null || value == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getText(widget.name) + " can not be empty.")));
      return;
    } else if (widget.name == Strings.EMAIL && !isEmail(value)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter valid e-mail id.")));
      return;
    } else {
      updateSharedPref(widget.name, encryptStr(value));
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(widget.name, encryptStr(value));
      });
    }
    Navigator.of(context).pop();
  }
}
