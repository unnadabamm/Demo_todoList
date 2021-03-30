import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:todolist_app/Components/text_field_container.dart';
import 'package:todolist_app/Model/usermodel.dart';
import 'package:todolist_app/UI/Register/register.dart';
import 'package:todolist_app/UI/Sidebar/sidebar_layout.dart';
import 'package:todolist_app/ulility/dialog.dart';
import 'package:todolist_app/ulility/my_constants.dart';
import 'package:todolist_app/ulility/text_style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadProcess = true;
  bool loadStatus = true;
  double screenHeight;
  String username, password;
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    usercheckLogin();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  Future<void> usercheckLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String state = preferences.getString('state');
      print('state>>$state');
      if (state == 'yes') {
        routoService(
          SideBarLayoutAssets(),
        );
      }
    } catch (e) {}
  }

  Future<void> usercheckAuthen() async {
    print(username);
    print(password);
    String url =
        '${MyConstant().domain}Login.php?select=true&userName=$username&passWords=$password';
    try {
      Response response = await Dio().get(url);
      print('res = $response');
      var result = json.decode(response.data);
      print('result>>>>>>>>$result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        String userState = userModel.userState;
        if (userState == 'yes') {
          // normalDialog(context, 'สามารถใช้งานได้');
          routeToService(SideBarLayoutAssets(), userModel);
        } else if (userState == 'no') {
          normalDialog(
              context, 'ถูกยกเลิกสิทธ์การเข้าใช้งานกรุณาติดต่อผู้ดูแลระบบ');
        } else {}
      }
    } catch (e) {
      normalDialog(context, 'ไม่มีข้อมูลผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง');
    }
  }

  Future<void> routeToService(Widget myWidget, UserModel userModels) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModels.id);
    preferences.setString('fullname', userModels.name);
    preferences.setString('img', userModels.avatar);
    preferences.setString('email', userModels.email);
    preferences.setString('state', userModels.userState);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  final formkey = GlobalKey<FormState>();
  String emailString, passwordString;

  Future<void> checkAuthen() async {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Container(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: blk30TextStyle,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SvgPicture.asset("assets/image/loginpic3.svg",
                      height: size.height * 0.3),
                  TextFieldContainer(
                    child: TextFormField(
                      onChanged: (value) => username = value.trim(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        hintText: "Your Email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      onChanged: (value) => password = value.trim(),
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Your Password",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    width: size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (username == null ||
                                username.isEmpty ||
                                password == null ||
                                password.isEmpty) {
                              normalDialog(
                                  context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
                            } else {
                              usercheckAuthen();
                            }
                          });
                        },
                        child: Material(
                          elevation: 10.0,
                          shadowColor: Color(0xFF8ED4F5),
                          color: Color(0xFFA743E0),
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: size.width,
                            height: size.width * 0.1,
                            child: Center(
                              child: Text('Log In', style: wl24TextStyle),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: nameStyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyRegister(),
                            ),
                          );
                        },
                        child: Text(
                          "Sing Up",
                          style: or16TextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void routoService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => myWidget));
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
