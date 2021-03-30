import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todolist_app/Model/usermodel.dart';
import 'package:todolist_app/ulility/my_constants.dart';
import 'package:todolist_app/ulility/text_style.dart';

class MyProfileList extends StatefulWidget {
  MyProfileList({Key key, this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  _MyProfileListState createState() => _MyProfileListState();
}

class _MyProfileListState extends State<MyProfileList> {
  UserModel userModel;
  String name, username, email, sexs, bod, phone, image, createDate, age;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    name = userModel.name;
    username = userModel.username;
    email = userModel.email;
    sexs = userModel.sexs;
    bod = userModel.bOD;
    phone = userModel.phone;
    image = userModel.avatar;
    createDate = userModel.createDate;
    age = userModel.age;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF031477),
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'personal'.toUpperCase(),
          style: wl18TextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.pink,
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 50,
                    backgroundImage: image.toString() == 'null' ||
                            image == null ||
                            image.isEmpty
                        ? AssetImage('assets/image/users.png')
                        : NetworkImage('${MyConstant().domain}avatar/$image'),
                  ),
                ),
              ),
            ),
            Container(
              width: size.width,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile'.toUpperCase(),
                      style: blue18TextStyle,
                    ),
                    Icon(
                      FontAwesomeIcons.userCircle,
                      size: 35,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'UserName'.toUpperCase(),
                      style: bl20TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                      username == null || username.isEmpty || username == 'null'
                          ? 'ไม่มีข้อมูล'
                          : '$username'.toLowerCase(),
                      style: bl18TextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Name'.toUpperCase(),
                      style: bl20TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                      name == null || name.isEmpty || name == 'null'
                          ? 'ไม่มีข้อมูล'
                          : '$name'.toLowerCase(),
                      style: bl18TextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'age'.toUpperCase(),
                      style: bl20TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                      age == null || age.isEmpty || age == 'null'
                          ? 'ไม่มีข้อมูล'
                          : '$age'.toUpperCase(),
                      style: bl18TextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'gender'.toUpperCase(),
                      style: bl20TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                      sexs == null || sexs.isEmpty || sexs == 'null'
                          ? 'ไม่มีข้อมูล'
                          : '$sexs'.toUpperCase(),
                      style: bl18TextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Bridth of Date'.toUpperCase(),
                      style: bl20TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                      bod == null || bod.isEmpty || bod == 'null'
                          ? 'ไม่มีข้อมูล'
                          : '$bod'.toUpperCase(),
                      style: bl18TextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Phone number'.toUpperCase(),
                      style: bl20TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                      phone == null || phone.isEmpty || phone == 'null'
                          ? 'ไม่มีข้อมูล'
                          : '$phone'.toUpperCase(),
                      style: bl18TextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('Phone number'.toUpperCase(),
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                      email == null || email.isEmpty || email == 'null'
                          ? 'ไม่มีข้อมูล'
                          : '$email'.toLowerCase(),
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
