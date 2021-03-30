import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:todolist_app/UI/Login/sign_in.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Future<void> checkStatus() async {}

    // void initState() {
    //   super.initState();
    //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // }

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -80,
            left: -80,
            child: Image.asset("assets/image/Ellipse1.png",
                width: size.width * 0.65),
          ),
          Positioned(
              bottom: -70,
              left: -70,
              child: Image.asset("assets/image/Ellipse3.png",
                  width: size.width * 0.5)),
          Padding(
            padding: EdgeInsets.only(bottom: 500),
            child: Text(
              "Welcome to ToDo List !",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: SvgPicture.asset(
              'assets/image/loginpic.svg',
              height: size.height * 0.42,
            ),
          ),
          Container(
            width: size.width * 0.6,
            child: Padding(
              padding: EdgeInsets.only(top: 320, bottom: 0),
              child: RaisedButton(
                  color: Colors.purple.shade300,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  }),
            ),
          )
          // Padding(
          //   padding: EdgeInsets.only(top: 300, bottom: 0),
          //   child: LoginButton(
          //     text: "LOGIN",
          //     press: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return LoginPage();
          //           },
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
