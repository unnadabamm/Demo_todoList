import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_app/UI/Sidebar/sidebar_layout.dart';
import 'package:todolist_app/ulility/dialog.dart';
import 'package:todolist_app/ulility/my_constants.dart';

import 'package:todolist_app/ulility/text_style.dart';

class MyNote extends StatefulWidget {
  @override
  _MyNoteState createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {
  String title, detail, date;
  DateTime dateTime;
  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
  }

  Future<void> insertNote() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    print('id>>$id');
    print('title>>$title');
    print('detail>>$detail');
    print('date>>$dateTime');
    String url =
        '${MyConstant().domain}addTodoNote.php?isAdd=true&title=$title&detail=$detail&date=$dateTime&userid=$id';
    await Dio().get(url).then(
      (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SideBarLayoutAssets()),
            (route) => false);
      },
    );
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.angleLeft, size: 30, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'note'.toUpperCase(),
          style: wl18TextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                icon: Icon(
                  Icons.check,
                  size: 30,
                ),
                onPressed: () {
                  if (title == null ||
                      title.isEmpty ||
                      detail == null ||
                      detail.isEmpty) {
                    normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
                  } else {
                    insertNote();
                  }
                }),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: bl15TextStyle,
                maxLines: 3,
                maxLength: 100,
                onChanged: (value) => title = value.trim(),
                decoration: InputDecoration(
                  labelText: "หัวเรื่อง",
                  labelStyle: bl18TextStyle,
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: bl15TextStyle,
                maxLines: 15,
                maxLength: 1000,
                onChanged: (value) => detail = value.trim(),
                decoration: InputDecoration(
                  labelText: "เนื้อหา",
                  labelStyle: bl18TextStyle,
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 8,
                child: ListTile(
                  subtitle: Text(
                    'ปี-เดือน-วัน',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
