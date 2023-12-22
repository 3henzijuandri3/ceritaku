class LoginResponseModel {
  final bool? error;
  final String? message;
  final LoginResult? loginResult;

  LoginResponseModel({
    this.error,
    this.message,
    this.loginResult
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json)
  => LoginResponseModel(
    error: json['error'],
    message: json['message'],
    loginResult: json['loginResult'] != null
        ? LoginResult.fromJson(json['loginResult'])
        : null
  );
}

class LoginResult {
  String? userId;
  String? name;
  String? token;

  LoginResult({this.userId, this.name, this.token});

  factory LoginResult.fromJson(Map<String, dynamic> json)
  => LoginResult(
      userId : json['userId'],
      name : json['name'],
      token : json['token'],
  );

  Map<String, dynamic> toJson() {
    return {
      'userId' : userId,
      'name' : name,
      'token' : token
    };
  }
}
