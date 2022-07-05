import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ReusableFromField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  String hintText;
  String label;
  final Function validator;
  final TextInputType textInputType;


  ReusableFromField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.validator,
    required this.hintText,
    required this.label,
    required this.textInputType,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      style: TextStyle(color: darkGrey),
      keyboardType: textInputType,
      validator: (value) => validator(value),
      decoration: InputDecoration(

          label: Text(
            label,
            style: TextStyle(color: black),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: TextStyle(fontWeight: FontWeight.bold)
      ),
    );
  }
}
