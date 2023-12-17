import 'dart:convert';

import 'package:ceritaku/models/register_form_model.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:http/http.dart' as http;

class AuthService{

  Future<String> register(RegisterFormModel registerData) async {
    try{

      final res = await http.post(
        Uri.parse('$baseUrl/register'),
        body: registerData.toJson()
      );

      return jsonDecode(res.body).toString();

    } catch(e) {
      rethrow;
    }
  }

}