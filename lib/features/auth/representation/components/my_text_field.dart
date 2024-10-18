import 'package:events_jo/config/my_colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: MyColors.lightYellow,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: MyColors.lightYellow,
          fontSize: 17,
        ),
        fillColor: MyColors.black,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.lightYellow,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.lightYellow,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
