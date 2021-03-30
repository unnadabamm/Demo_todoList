import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timelines/timelines.dart';
import 'package:todolist_app/Model/usernote.dart';
import 'package:todolist_app/UI/myDetail.dart';
import 'package:todolist_app/UI/myNote.dart';
import 'package:todolist_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:todolist_app/ulility/my_constants.dart';
import 'package:todolist_app/ulility/my_style.dart';
import 'package:todolist_app/ulility/text_style.dart';

class MyTodoList extends StatefulWidget with NavigationStates {
  @override
  _MyTodoListState createState() => _MyTodoListState();
}

class _MyTodoListState extends State<MyTodoList> {
  List<UserNote> userNote = [];
  bool loadState = true;
  bool loadUser = true;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getUser();
    });
    return null;
  }

  Future<void> getUser() async {
    if (userNote.length != 0) {
      userNote.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    print("id>>>>>$id");
    String url = "${MyConstant().domain}getTodoNote.php?select=true&id=$id";

    await Dio().get(url).then((value) {
      setState(() {
        loadState = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          UserNote userNotes = UserNote.fromJson(map);
          setState(() {
            userNote.add(userNotes);
          });
        }
      } else {
        loadUser = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyNote(),
            ),
          );
        },
        child: Icon(FontAwesomeIcons.edit),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'Book mark'.toUpperCase(),
            style: bl20TextStyle,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: loadState ? MyStyle().showProgress() : showNoContent(size),
        ),
      ),
    );
  }

  Widget showContent(Size size) {
    return Timeline.tileBuilder(
      builder: TimelineTileBuilder.fromStyle(
        itemCount: userNote.length,
        contentsAlign: ContentsAlign.alternating,
        oppositeContentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${userNote[index].date}',
            style: bl12TextStyle,
          ),
        ),
        contentsBuilder: (context, index) => Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyDetail(
                      userNote: userNote[index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Card(
                  elevation: 8,
                  child: Container(
                    height: size.height * 0.12,
                    child: ListTile(
                        title: Text(
                          '${userNote[index].title}',
                          style: bl10TextStyle,
                          maxLines: 2,
                        ),
                        subtitle: Text(
                          '${userNote[index].detail}',
                          style: bl8TextStyle,
                          maxLines: 4,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showNoContent(size) {
    Size size = MediaQuery.of(context).size;
    return loadUser
        ? showContent(size)
        : Container(
            height: size.height * 0.8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ไม่มีรายการบันทึกความจำ',
                    style: bl18TextStyle,
                  ),
                ],
              ),
            ),
          );
  }
}
