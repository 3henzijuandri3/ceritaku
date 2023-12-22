import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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

class BigBorderInputCustom extends StatelessWidget {
  final String formHint;
  final TextEditingController? controller;
  final TextInputType? inputType;

  const BigBorderInputCustom({
    super.key,
    required this.formHint,
    this.controller,
    this.inputType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 6,
      textAlign: TextAlign.start,
      keyboardType: inputType,
      controller: controller,

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: formHint,
        hintStyle: GoogleFonts.nunitoSans(
          color: greyColor,
          fontSize: 16,
          fontWeight: light,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: greenColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: blueColor,
          ),
        ),
      ),
    );
  }
}