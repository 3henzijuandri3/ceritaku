import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

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

Future<XFile?> selectImageGallery() async {

  XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  return selectedImage;
}

Future<XFile?> selectImageCamera() async {

  XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);

  return selectedImage;
}

File resizeImage(File originalImageFile, {int width = 800}) {
  final img.Image originalImage = img.decodeImage(originalImageFile.readAsBytesSync())!;
  final img.Image resizedImage = img.copyResize(originalImage, width: width);

  // Create a temporary file for the resized image
  final String tempImagePath = originalImageFile.path.replaceAll('.jpg', '_resized.jpg');
  final File resizedImageFile = File(tempImagePath)..writeAsBytesSync(img.encodeJpg(resizedImage));

  return resizedImageFile;
}