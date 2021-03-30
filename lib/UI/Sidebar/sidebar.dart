import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_app/Model/usermodel.dart';
import 'package:todolist_app/UI/Sidebar/menu_Item.dart';
import 'package:todolist_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:todolist_app/ulility/my_constants.dart';

// import 'menu_item.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todolist_app/ulility/my_style.dart';
import 'package:todolist_app/ulility/process_sigout.dart';
import 'package:todolist_app/ulility/text_style.dart';

class SideBarAssets extends StatefulWidget {
  @override
  _SideBarAssetsState createState() => _SideBarAssetsState();
}

class _SideBarAssetsState extends State<SideBarAssets>
    with SingleTickerProviderStateMixin<SideBarAssets> {
  bool loadUsers = true;
  String image, name, email;
  UserModel userModel;
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    readData();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  Future<void> readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String url = "${MyConstant().domain}getUser.php?select=true&id=$id";
    await Dio().get(url).then((value) {
      setState(() {
        loadUsers = false;
      });
      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print(result);
        for (var map in result) {
          setState(() {
            userModel = UserModel.fromJson(map);
            image = userModel.avatar;
            name = userModel.name;
            email = userModel.email;
          });
          print(image);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return loadUsers
        ? MyStyle().showProgress()
        : StreamBuilder<bool>(
            initialData: false,
            stream: isSidebarOpenedStream,
            builder: (context, isSideBarOpenedAsync) {
              return AnimatedPositioned(
                duration: _animationDuration,
                top: 0,
                bottom: 0,
                left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
                right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Color(0xFFF09C3D),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                            ),
                            ListTile(
                              title: Text(
                                name,
                                style: wl18TextStyle,
                              ),
                              subtitle: Text(email.toLowerCase(),
                                  style: blue12TextStyle),
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundColor: Color(0xFFFAFAFA),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.redAccent,
                                  backgroundImage: image.toString() == 'null'
                                      ? AssetImage('assets/image/user.png')
                                      : NetworkImage(
                                          '${MyConstant().domain}avatar/$image'),
                                ),
                              ),
                            ),
                            Divider(
                              height: 64,
                              thickness: 0.5,
                              color: Colors.white.withOpacity(0.3),
                              indent: 32,
                              endIndent: 32,
                            ),
                            MenuItem(
                              icon: FontAwesomeIcons.users,
                              title: "Users List".toUpperCase(),
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.MyUserListClickedEvent);
                              },
                            ),
                            MenuItem(
                              icon: FontAwesomeIcons.calculator,
                              title: "Calculator".toUpperCase(),
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.MyCalculatorClickedEvent);
                              },
                            ),
                            MenuItem(
                              icon: FontAwesomeIcons.list,
                              title: "Todo List".toUpperCase(),
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.MyTodoListClickedEvent);
                              },
                            ),
                            Divider(
                              height: 64,
                              thickness: 0.5,
                              color: Colors.white.withOpacity(0.3),
                              indent: 32,
                              endIndent: 32,
                            ),
                            MenuItem(
                              icon: FontAwesomeIcons.signOutAlt,
                              title: "Log out".toUpperCase(),
                              onTap: () {
                                processSignOut(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -0.9),
                      child: GestureDetector(
                        onTap: () {
                          onIconPressed();
                        },
                        child: ClipPath(
                          clipper: CustomMenuClipper(),
                          child: Container(
                            width: 35,
                            height: 110,
                            color: Color(0xFFF09C3D),
                            alignment: Alignment.centerLeft,
                            child: AnimatedIcon(
                              progress: _animationController.view,
                              icon: AnimatedIcons.menu_close,
                              color: Color(0xFFE20000),
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
