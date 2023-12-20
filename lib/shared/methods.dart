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

String formatDate(String responseDate) {
  DateTime dateTime = DateTime.parse(responseDate);

  String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

  return formattedDate;
}

String relativeTime(String responseDate) {
  DateTime dateTime = DateTime.parse(responseDate);

  Duration difference = DateTime.now().toUtc().difference(dateTime);

  String relativeTime = formatRelativeTime(difference);

  return relativeTime;
}

String formatRelativeTime(Duration difference) {
  if (difference.inSeconds < 60) {
    return "${difference.inSeconds}s ago";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes}m ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h ago";
  } else {
    return "${difference.inDays}d ago";
  }
}