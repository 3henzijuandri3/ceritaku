import 'dart:io';

class UploadCeritaFormModel{
  final String? description;
  final File? photo;
  final double? lat;
  final double? lon;

  UploadCeritaFormModel({
    this.description,
    this.photo,
    this.lat,
    this.lon
  });

  Map<String, dynamic> tJson(){
    return {
      'description' : description,
      'photo' : photo,
      'lat' : lat,
      'lon' : lon
    };
  }
}

class UploadCeritaResponseModel {
  final bool? error;
  final String? message;

  UploadCeritaResponseModel({
    this.error,
    this.message,
  });

  factory UploadCeritaResponseModel.fromJson(Map<String, dynamic> json)
  => UploadCeritaResponseModel(
      error: json['error'],
      message: json['message'],
  );
}