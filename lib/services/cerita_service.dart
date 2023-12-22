import 'dart:convert';
import 'dart:developer';

import 'package:ceritaku/models/cerita/cerita_detail_model.dart';
import 'package:ceritaku/services/auth_service.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:http/http.dart' as http;

import '../models/cerita/list_cerita_model.dart';

class CeritaService{

  Future<ListCeritaModel> getListCerita() async {
    try{

      String authToken = await AuthService().getToken();

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

  Future<ListCeritaModel> getListCeritaLocation() async {
    try{

      String authToken = await AuthService().getToken();

      final res = await http.get(
          Uri.parse('$baseUrl/stories?location=1&size=20'),
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

  Future<CeritaDetailModel> getCeritaDetail(String id) async {
    try{

      String authToken = await AuthService().getToken();

      final res = await http.get(
          Uri.parse('$baseUrl/stories/$id'),
          headers: {
            'Authorization' : authToken
          }
      );

      CeritaDetailModel detailCeritaResponse = CeritaDetailModel.fromJson(jsonDecode(res.body));

      return detailCeritaResponse;

    } catch(e) {
      rethrow;
    }
  }

}