import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolist_app/ulility/text_style.dart';



Future<void> normalDialog(BuildContext context, String title) async {
  Alert(
    context: context,
    type: AlertType.warning,
    title: title,
    style: AlertStyle(titleStyle: bl15TextStyle),
    buttons: [
      DialogButton(
        child: Text(
          "ตกลง",
          style: bl20TextStyle,
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}
