import 'package:flutter/material.dart';
import 'package:todolist_app/Components/text_field_container.dart';

class InputPassword extends StatelessWidget {
  final ValueChanged onChange;
  const InputPassword({
    Key key, this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChange,
        decoration: InputDecoration(
            hintText: "Your Password",
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            suffixIcon: Icon(
              Icons.visibility,
              color: Colors.grey.withOpacity(0.3),
            ),
            border: InputBorder.none),
      ),
    );
  }
}