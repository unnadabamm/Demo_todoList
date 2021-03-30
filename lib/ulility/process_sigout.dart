
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_app/UI/Login/sign_in.dart';


Future<void> processSignOut(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear().then((value) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => LoginPage(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  });
}
