// import 'package:flutter/material.dart';
// import 'package:todolist_app/Components/text_field_container.dart';

// class InputEmail extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
  
  
//   // ignore: non_constant_identifier_names
//   final ValueChanged onChange;

//   const InputEmail({
    
//     Key key,
//     this.hintText,
//     this.icon = Icons.person,
//     this.onChange,
//     Null Function() onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return 
//     TextFieldContainer(
//       child: TextFormField(
//         onChanged: onChange,
//           onSaved: (String value) {
//             emailString = value;
//           },
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//           icon: Icon(
//             icon,
//             color: Colors.grey,
//           ),
//           hintText: hintText,
//           border: InputBorder.none,
          
//         ),
//       ),
//     );
//   }
// }
