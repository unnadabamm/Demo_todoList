// import 'package:flutter/material.dart';

// import 'package:todolist_app/bloc.navigation_bloc/navigation_bloc.dart';
// import 'package:todolist_app/ulility/text_style.dart';


// class MyCalculator extends StatefulWidget with NavigationStates {
//   MyCalculator({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyCalculatorState createState() => _MyCalculatorState();
// }

// class _MyCalculatorState extends State<MyCalculator> {
//   String answer, answerTemp, inputFull, operator;
//   bool calculateMode;
//   @override
//   void initState() {
  
//     super.initState();
//     answer = "0";
//     operator = "";
//     answerTemp = "";
//     inputFull = "";
//     calculateMode = false;
//   }

//   Future<void> toggleNegative() async {
//     setState(() {
//       if (answer.contains("-")) {
//         answer = answer.replaceAll("-", "");
//       } else {
//         answer = "-" + answer;
//       }
//     });
//   }

//   Future<void> clearAnswer() async {
//     setState(() {
//       answer = "0";
//     });
//   }

//   Future<void> clearAll() async {
//     setState(() {
//       answer = "0";
//       inputFull = "";
//       calculateMode = false;
//       operator = "";
//     });
//   }

//   Future<void> calculate() async {
//     setState(() {
//       if (calculateMode) {
//         bool decimalMode = false;
//         double value = 0;
//         if (answer.contains(".") || answerTemp.contains(".")) {
//           decimalMode = true;
//         }

//         if (operator == "+") {
//           value = (double.parse(answerTemp) + double.parse(answer));
//         } else if (operator == "-") {
//           value = (double.parse(answerTemp) - double.parse(answer));
//         } else if (operator == "×") {
//           value = (double.parse(answerTemp) * double.parse(answer));
//         } else if (operator == "÷") {
//           value = (double.parse(answerTemp) / double.parse(answer));
//         }

//         if (!decimalMode) {
//           answer = value.toInt().toString();
//         } else {
//           answer = value.toString();
//         }

//         calculateMode = false;
//         operator = "";
//         answerTemp = "";
//         inputFull = "";
//       }
//     });
//   }

//   Future<void> addOperatorToAnswer(String op) async {
//     setState(() {
//       if (answer != "0" && !calculateMode) {
//         calculateMode = true;
//         answerTemp = answer;
//         inputFull += operator + " " + answerTemp;
//         operator = op;
//         answer = "0";
//       } else if (calculateMode) {
//         if (answer.isNotEmpty) {
//           calculate();
//           answerTemp = answer;
//           inputFull = "";
//           operator = "";
//         } else {
//           operator = op;
//         }
//       }
//     });
//   }

//   Future<void> addDotToAnswer() async {
//     setState(() {
//       if (!answer.contains(".")) {
//         answer = answer + ".";
//       }
//     });
//   }

//   Future<void> addNumberToAnswer(int number) async {
//     setState(() {
//       if (number == 0 && answer == "0") {
//       } else if (number != 0 && answer == "0") {
//         answer = number.toString();
//       } else {
//         answer += number.toString();
//       }
//     });
//   }

//   Future<void> removeAnswerLast() async {
//     if (answer == "0") {
//     } else {
//       setState(() {
//         if (answer.length > 1) {
//           answer = answer.substring(0, answer.length - 1);
//           if (answer.length == 1 && (answer == "." || answer == "-")) {
//             answer = "0";
//           }
//         } else {
//           answer = "0";
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 10),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 80,
//                 ),
//                 Text(
//                   'my calculator'.toUpperCase(),
//                   style: bl24TextStyle,
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 showAnswer(size),
//                 showNumber()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget showNumber() {
//     return Container(
//       color: Color(0xffdbdbdb),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Row(children: <Widget>[
//             buildNumberButton("CE", numberBtn: false, onTap: () {
//               clearAnswer();
//             }),
//             buildNumberButton("C", numberBtn: false, onTap: () {
//               clearAll();
//             }),
//             buildNumberButton("⌫", numberBtn: false, onTap: () {
//               removeAnswerLast();
//             }),
//             buildNumberButton("÷", numberBtn: false, onTap: () {
//               addOperatorToAnswer("÷");
//             }),
//           ]),
//           Row(children: <Widget>[
//             buildNumberButton("7", onTap: () {
//               addNumberToAnswer(7);
//             }),
//             buildNumberButton("8", onTap: () {
//               addNumberToAnswer(8);
//             }),
//             buildNumberButton("9", onTap: () {
//               addNumberToAnswer(9);
//             }),
//             buildNumberButton("×", numberBtn: false, onTap: () {
//               addOperatorToAnswer("×");
//             }),
//           ]),
//           Row(children: <Widget>[
//             buildNumberButton("4", onTap: () {
//               addNumberToAnswer(4);
//             }),
//             buildNumberButton("5", onTap: () {
//               addNumberToAnswer(5);
//             }),
//             buildNumberButton("6", onTap: () {
//               addNumberToAnswer(6);
//             }),
//             buildNumberButton("−", numberBtn: false, onTap: () {
//               addOperatorToAnswer("-");
//             }),
//           ]),
//           Row(children: <Widget>[
//             buildNumberButton("1", onTap: () {
//               addNumberToAnswer(1);
//             }),
//             buildNumberButton("2", onTap: () {
//               addNumberToAnswer(2);
//             }),
//             buildNumberButton("3", onTap: () {
//               addNumberToAnswer(3);
//             }),
//             buildNumberButton("+", numberBtn: false, onTap: () {
//               addOperatorToAnswer("+");
//             }),
//           ]),
//           Row(children: <Widget>[
//             buildNumberButton("±", numberBtn: false, onTap: () {
//               toggleNegative();
//             }),
//             buildNumberButton("0", onTap: () {
//               addNumberToAnswer(0);
//             }),
//             buildNumberButton(".", numberBtn: false, onTap: () {
//               addDotToAnswer();
//             }),
//             buildNumberButton("=", numberBtn: false, onTap: () {
//               calculate();
//             }),
//           ]),
//         ],
//       ),
//     );
//   }

//   Widget showAnswer(size) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       constraints: BoxConstraints.expand(height: size.height * 0.25),
//       color: Color(0xffecf0f1),
//       child: Align(
//         alignment: Alignment.bottomRight,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               inputFull + " " + operator,
//               style: bl18TextStyle,
//             ),
//             Text(
//               answer,
//               style: bl24TextStyle,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildNumberButton(String str,
//       {@required Function() onTap, bool numberBtn = true}) {
//     Widget widget;
//     if (numberBtn) {
//       widget = Container(
//         margin: EdgeInsets.all(1),
//         child: Material(
//           color: Colors.white,
//           child: InkWell(
//             onTap: onTap,
//             splashColor: Colors.blue,
//             child: Container(
//               height: 70,
//               child: Center(
//                 child: Text(str, style: bl24TextStyle),
//               ),
//             ),
//           ),
//         ),
//       );
//     } else {
//       widget = Container(
//         margin: EdgeInsets.all(1),
//         child: Material(
//           color: Color(0xffecf0f1),
//           child: InkWell(
//             onTap: onTap,
//             splashColor: Colors.blue,
//             child: Container(
//               height: 70,
//               child: Center(
//                 child: Text(str, style: bl24TextStyle),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return Expanded(child: widget);
//   }
// }
