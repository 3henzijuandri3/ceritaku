import 'dart:convert';
import 'package:ceritaku/models/auth/login_form_model.dart';
import 'package:ceritaku/models/auth/login_response_model.dart';
import 'package:ceritaku/models/auth/register_form_model.dart';
import 'package:ceritaku/models/auth/register_response_model.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
      LoginResult? userData = loginResponse.loginResult;

      if(userData != null){
        await storeUserDataToLocal(userData);
      }

      return loginResponse;

    } catch(e) {
      rethrow;
    }
  }

  Future<void> storeUserDataToLocal(LoginResult userData) async {

    try{

      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: userData.token);
      await storage.write(key: 'name', value: userData.name);
      await storage.write(key: 'id', value: userData.userId);

    } catch(e) {
      rethrow;
    }

  }

  Future<String> getUserName() async {

    try{
      String name = '';

      const storage = FlutterSecureStorage();
      String? values = await storage.read(key: 'name');

      if(values != null){
        name = values;
      }
      return name;

    } catch(e){
      rethrow;
    }

  }

  Future<String> getToken() async {

    try{
      String token = '';

      const storage = FlutterSecureStorage();
      String? values = await storage.read(key: 'token');

      if(values != null){
        token = 'Bearer $values';
      }

      return token;

    } catch(e){
      rethrow;
    }

  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}