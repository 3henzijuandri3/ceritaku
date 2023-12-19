class RegisterResponseModel{
  final bool? error;
  final String? message;

  RegisterResponseModel({
    this.error,
    this.message
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json)
  =>
      RegisterResponseModel(
        error: json['error'],
        message: json['message'],
      );
}