import 'package:another_flushbar/flushbar.dart';
import 'package:ceritaku/shared/theme.dart';
import 'package:flutter/cupertino.dart';

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}