import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todolist_app/ulility/dialog.dart';
import 'package:todolist_app/ulility/my_constants.dart';
import 'package:todolist_app/ulility/text_style.dart';

class MyRegister extends StatefulWidget {
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  DateTime dateTime;
  File file;
  String userName, passWords, confrimPasswors, name, eMail, sexs, phone;
  bool loadState = true;
  bool loadUsername = true;
  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    sexs = 'ชาย';
  }

  Future<void> checkUsername() async {
    print('username  $userName');
    String url =
        "${MyConstant().domain}getUsername.php?select=true&userName=$userName";

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('res>>>$result');
    if (result == null) {
      chackConfrim();
    } else {
      normalDialog(context, '$userName ถูกใช้ไปแล้ว');
    }
  }

  Future<void> registerUser() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String avatar = 'avatar$i.png';

    String urlSaveFile = '${MyConstant().domain}saveAvatar.php';
    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: avatar);
      print('pathFile = ${file.path}, ${map.toString()}');

      FormData formData = FormData.fromMap(map);
      Dio().post(urlSaveFile, data: formData).then((value) {
        print('Response========> $value');
        setState(() async {
          String url =
              "${MyConstant().domain}Register.php?isAdd=true&userName=$userName&passWords=$passWords&name=$name&sexs=$sexs&BOD=$dateTime&email=$eMail&avatar=$avatar&phone=$phone";
          await Dio().get(url).then((value) {
            setState(() {
              Navigator.pop(
                context,
              );
            });
          });
        });
      });
    } catch (e) {}
  }

  Future<void> chackConfrim() async {
    if (passWords == confrimPasswors) {
      registerUser();
    } else {
      normalDialog(
          context, 'รหัสผ่านใหม่ไม่ตรงกัน \nกรุณากรองข้อมูลใหม่อีกครั้ง');
    }
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxHeight: 600.0, maxWidth: 600.0);
      setState(() {
        file = File(object.path);
        print('file>>>>>>>>>>>>$file');
      });
    } catch (e) {}
  }

  Future<void> choosefirstDate() async {
    DateTime chooseDateTime = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
    );
    if (chooseDateTime != null) {
      setState(() {
        dateTime = chooseDateTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(FontAwesomeIcons.users),
        title: Text(
          'register'.toUpperCase(),
          style: wl18TextStyle,
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.check,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                if (file == null) {
                  normalDialog(context, 'กรุณาเลือกรูปภาพ');
                } else if (userName == null ||
                    userName.isEmpty ||
                    passWords == null ||
                    passWords.isEmpty ||
                    confrimPasswors == null ||
                    confrimPasswors.isEmpty ||
                    name == null ||
                    name.isEmpty ||
                    phone == null ||
                    phone.isEmpty ||
                    eMail == null ||
                    eMail.isEmpty) {
                  normalDialog(context, 'กรุณากรอกข้อมูลให้ครับถ้วน');
                } else {
                  checkUsername();
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.grey.shade200,
                          child: CircleAvatar(
                            backgroundColor: Colors.pink.shade200,
                            radius: 50,
                            backgroundImage: file == null
                                ? AssetImage('assets/image/users.png')
                                : FileImage(file),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 110,
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.blue.withOpacity(0.3)),
                        ),
                        color: Colors.white54,
                        onPressed: () {
                          chooseImage(ImageSource.gallery);
                        },
                        child: Icon(
                          FontAwesomeIcons.image,
                          color: Colors.lightBlue,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 5,
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.blue.withOpacity(0.3)),
                        ),
                        color: Colors.white54,
                        onPressed: () {
                          chooseImage(ImageSource.camera);
                        },
                        child: Icon(
                          Icons.camera,
                          color: Colors.lightBlue,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 3, bottom: 3, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: bl18TextStyle,
                    ),
                    Icon(
                      Icons.add_circle,
                      color: Colors.blueGrey,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextFormField(
                    style: bl20TextStyle,
                    onChanged: (value) => userName = value.trim(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    decoration: InputDecoration(
                      labelText: 'USERNAME',
                      labelStyle: bl12TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextFormField(
                    obscureText: true,
                    style: bl20TextStyle,
                    onChanged: (value) => passWords = value.trim(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    decoration: InputDecoration(
                      labelText: 'PASSWORDS',
                      labelStyle: bl12TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextFormField(
                    obscureText: true,
                    style: bl20TextStyle,
                    onChanged: (value) => confrimPasswors = value.trim(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    decoration: InputDecoration(
                      labelText: 'comfrim passwords'.toUpperCase(),
                      labelStyle: bl12TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextFormField(
                    style: bl18TextStyle,
                    onChanged: (value) => name = value.trim(),
                    decoration: InputDecoration(
                      labelText: 'ชื่อ-นามสกุล',
                      labelStyle: bl12TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [showMan(), showWomen()],
            ),
            showDateFrom(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextFormField(
                    style: bl18TextStyle,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => phone = value.trim(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      labelText: 'เบอร์มือถือ',
                      labelStyle: bl12TextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextFormField(
                    style: bl18TextStyle,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => eMail = value.trim(),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: bl12TextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showMan() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
              value: 'ชาย',
              groupValue: sexs,
              onChanged: (value) {
                setState(() {
                  sexs = value;
                });
              }),
          Text(
            'ชาย',
            style: bl12TextStyle,
          ),
        ]);
  }

  Widget showWomen() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
              value: 'หญิง',
              groupValue: sexs,
              onChanged: (value) {
                setState(() {
                  sexs = value;
                });
              }),
          Text(
            'หญิง',
            style: bl12TextStyle,
          ),
        ]);
  }

  Widget showDateFrom() {
    return ListTile(
      subtitle: Text(
        'ปี-เดือน-วัน/เกิด',
        style: bl12TextStyle,
      ),
      onLongPress: () {},
      leading: Icon(
        FontAwesomeIcons.calendarCheck,
        color: Colors.blue,
        size: 25,
      ),
      title: Text(
        '${dateTime.year}-${dateTime.month}-${dateTime.day}',
        style: bl12TextStyle,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.blue,
      ),
      onTap: () {
        choosefirstDate();
      },
    );
  }
}
