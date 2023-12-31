import 'package:flutter/material.dart';
import 'package:joga_junto/theme/pallete.dart';

class CommonStyle{
  static const bodyPading = EdgeInsets.symmetric(horizontal: 5, vertical: 25);
  static const formFieldPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 24);
  static const buttonPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 12);


  static InputDecoration textFieldStyle({
    String labelText="",
    String hintText=""
    }) {
    return InputDecoration(
      labelText: labelText,
      hintText:hintText,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
    );
  }

  static ButtonStyle buttonStyle() {
    return ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll<Color>(Pallete.orangeColor),
      minimumSize: const MaterialStatePropertyAll<Size>(Size(double.infinity, 50)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}