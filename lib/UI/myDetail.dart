import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolist_app/Model/usernote.dart';
import 'package:todolist_app/UI/Sidebar/sidebar_layout.dart';
import 'package:todolist_app/ulility/my_constants.dart';

import 'package:todolist_app/ulility/text_style.dart';

class MyDetail extends StatefulWidget {
  MyDetail({Key key, this.userNote}) : super(key: key);
  final UserNote userNote;

  @override
  _MyDetailState createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  UserNote userNote;
  String title, detail, id;
  DateTime date;

  @override
  void initState() {
   
    super.initState();
    userNote = widget.userNote;
    id = userNote.id;
    title = userNote.title;
    detail = userNote.detail;
    date = DateTime.parse(userNote.date);
  }

  Future<void> normalDialogUpdate(
      BuildContext context, String strtitle, UserNote userNote) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: bl18TextStyle,
      ),
      onPressed: () async {
        print('title>>$title');
        print('detail>>$detail');
        print('date>>$date');
        // Navigator.pop(context);
        String url =
            '${MyConstant().domain}updateNote.php?isupdate=true&title=$title&detail=$detail&date=$date&id=$id';
        await Dio().get(url).then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SideBarLayoutAssets()),
            (route) => false));
      },
      // gradient: LinearGradient(colors: [
      //   Color.fromRGBO(116, 116, 191, 1.0),
      //   Color.fromRGBO(52, 138, 199, 1.0)
      // ]),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      title: strtitle,
      style: AlertStyle(titleStyle: bl15TextStyle),
      buttons: [
        DialogButton(
          child: Text(
            "NO",
            style: bl18TextStyle,
          ),
          onPressed: () => Navigator.pop(context),
          // gradient: LinearGradient(colors: [
          //   Color.fromRGBO(116, 116, 191, 1.0),
          //   Color.fromRGBO(52, 138, 199, 1.0)
          // ]),
        ),
        dialogButton
      ],
    ).show();
  }

  Future<void> normalDialogDelete(
      BuildContext context, String strtitle, UserNote userNote) async {
    var dialogButton = DialogButton(
      child: Text(
        "YES",
        style: bl18TextStyle,
      ),
      onPressed: () async {
        Navigator.pop(context);
        String url =
            '${MyConstant().domain}deleteNote.php?isupdate=true&id=$id';
        await Dio().get(url).then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SideBarLayoutAssets()),
            (route) => false));
      },
      // gradient: LinearGradient(colors: [
      //   Color.fromRGBO(116, 116, 191, 1.0),
      //   Color.fromRGBO(52, 138, 199, 1.0)
      // ]),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      title: strtitle,
      style: AlertStyle(titleStyle: bl15TextStyle),
      buttons: [
        DialogButton(
          child: Text(
            "NO",
            style: bl18TextStyle,
          ),
          onPressed: () => Navigator.pop(context),
          // gradient: LinearGradient(colors: [
          //   Color.fromRGBO(116, 116, 191, 1.0),
          //   Color.fromRGBO(52, 138, 199, 1.0)
          // ]),
        ),
        dialogButton
      ],
    ).show();
  }

  Future<void> choosefirstDate() async {
    DateTime chooseDateTime = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
    );
    if (chooseDateTime != null) {
      setState(() {
        date = chooseDateTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon:
                Icon(FontAwesomeIcons.angleLeft, size: 30, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Note'.toUpperCase(),
            style: wl18TextStyle,
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 25,
                ),
                onPressed: () {
                  normalDialogDelete(
                      context, "คุณต้องการลบใช่หรือไม่", userNote);
                }),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.check,
                  size: 30,
                ),
                onPressed: () {
                  normalDialogUpdate(
                      context, 'คุณต้องการบันทึกใช่หรือไม่', userNote);
                })
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: bl15TextStyle,
                initialValue: title,
                maxLines: 3,
                maxLength: 100,
                onChanged: (value) => title = value.trim(),
                decoration: InputDecoration(
                  labelText: "หัวเรื่อง",
                  labelStyle: bl18TextStyle,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: bl15TextStyle,
                initialValue: detail,
                maxLines: 15,
                maxLength: 1000,
                onChanged: (value) => detail = value.trim(),
                decoration: InputDecoration(
                  labelText: "เนื้อหา",
                  labelStyle: bl18TextStyle,
                  border: OutlineInputBorder(),
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
                    '${date.year}-${date.month}-${date.day}',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
