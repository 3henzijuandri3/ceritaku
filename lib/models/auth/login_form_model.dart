class LoginFormModel {
  final String? email;
  final String? password;

  LoginFormModel({
    this.email,
    this.password
  });

  Map<String, dynamic> toJson(){
    return {
      'email' : email,
      'password' : password
    };
  }
}