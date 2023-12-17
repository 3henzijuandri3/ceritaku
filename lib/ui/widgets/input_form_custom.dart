import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class FilledInputCustom extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? inputType;

  const FilledInputCustom({super.key, this.hintText, required this.obscureText, this.controller, this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,

      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,

          hintStyle: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular
          ),

          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)
          ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: greenColor)
          )
      ),
    );
  }
}
