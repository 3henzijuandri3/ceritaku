import 'dart:convert';
import 'dart:developer';

import 'package:ceritaku/models/auth/login_form_model.dart';
import 'package:ceritaku/models/auth/login_response_model.dart';
import 'package:ceritaku/models/auth/register_form_model.dart';
import 'package:ceritaku/models/auth/register_response_model.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:http/http.dart' as http;

class AuthService{

  Future<RegisterResponseModel> register(RegisterFormModel registerData) async {
    try{

      final res = await http.post(
        Uri.parse('$baseUrl/register'),
        body: registerData.toJson()
      );

      RegisterResponseModel registerResponse = RegisterResponseModel.fromJson(jsonDecode(res.body));

      return registerResponse;

    } catch(e) {
      rethrow;
    }
  }

  Future<LoginResponseModel> login(LoginFormModel loginData) async {
    try{

      final res = await http.post(
          Uri.parse('$baseUrl/login'),
          body: loginData.toJson()
      );

      LoginResponseModel loginResponse = LoginResponseModel.fromJson(jsonDecode(res.body));

      return loginResponse;

    } catch(e) {
      rethrow;
    }
  }
}