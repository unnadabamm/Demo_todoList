import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:todolist_app/Model/usermodel.dart';
import 'package:todolist_app/UI/myProfilelist.dart';
import 'package:todolist_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:todolist_app/ulility/my_constants.dart';
import 'package:todolist_app/ulility/my_style.dart';
import 'package:todolist_app/ulility/text_style.dart';

class MyUserList extends StatefulWidget with NavigationStates {
  @override
  _MyUserListState createState() => _MyUserListState();
}

class _MyUserListState extends State<MyUserList> {
  bool loadState = true;
  bool loadUser = true;
  List<UserModel> userModel = [];
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
    if (userModel.length != 0) {
      userModel.clear();
    }
    String url = "${MyConstant().domain}getListUser.php?select=true";

    await Dio().get(url).then((value) {
      setState(() {
        loadState = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          UserModel usesmodel = UserModel.fromJson(map);
          setState(() {
            userModel.add(usesmodel);
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
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 20),
                child: Text(
                  'Users list'.toUpperCase(),
                  style: bl24TextStyle,
                ),
              ),
            ),
            loadState ? MyStyle().showProgress() : showNoContent(size)
          ],
        ),
      ),
    );
  }

  Widget showContent(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.85,
      child: RefreshIndicator(
        onRefresh: refreshList,
        child: ListView.builder(
            itemCount: userModel.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 5, top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Card(
                    color: Color(0xFFE7E6E6),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            child: CircleAvatar(
                              radius: 19,
                              backgroundImage: userModel[index]
                                              .avatar
                                              .toString() ==
                                          'null' ||
                                      userModel[index].avatar.isEmpty
                                  ? AssetImage('assets/image/user.png')
                                  : NetworkImage(
                                      '${MyConstant().domain}avatar/${userModel[index].avatar}'),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyProfileList(
                                  userModel: userModel[index],
                                ),
                              ),
                            );
                          },
                          title: Container(
                            width: size.width * 1,
                            child: Text(
                              "${userModel[index].name}",
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ),
                          subtitle: Container(
                            width: size.width * 1,
                            child: Text(
                              "${userModel[index].email}",
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                        // Divider(
                        //   thickness: 2.0,
                        // )
                      ],
                    ),
                  ),
                ),
              );
            }),
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
              child: Text(
                'ไม่มีรายการประวัติ',
              ),
            ),
          );
  }
}
