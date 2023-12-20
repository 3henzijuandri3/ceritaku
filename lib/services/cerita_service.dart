import 'dart:convert';
import 'dart:developer';

import 'package:ceritaku/shared/value.dart';
import 'package:http/http.dart' as http;

import '../models/auth/list_cerita_model.dart';

class CeritaService{

  Future<ListCeritaModel> getListCerita(String authToken) async {
    try{
      final res = await http.get(
        Uri.parse('$baseUrl/stories'),
        headers: {
          'Authorization' : authToken
        }
      );

      ListCeritaModel listCeritaResponse = ListCeritaModel.fromJson(jsonDecode(res.body));

      return listCeritaResponse;

    } catch(e) {
      rethrow;
    }
  }

}