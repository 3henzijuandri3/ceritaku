import 'dart:convert';

import 'package:ceritaku/models/cerita/cerita_detail_model.dart';
import 'package:ceritaku/services/auth_service.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:http/http.dart' as http;

import '../models/cerita/list_cerita_model.dart';
import '../models/cerita/upload_cerita_form_model.dart';

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

  Future<UploadCeritaResponseModel> uploadCerita(UploadCeritaFormModel uploadData) async {
    try {
      String authToken = await AuthService().getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/stories'),
      );

      // Add form fields
      request.fields['description'] = uploadData.description!;
      if (uploadData.lat != null) {
        request.fields['lat'] = uploadData.lat.toString();
      }
      if (uploadData.lon != null) {
        request.fields['lon'] = uploadData.lon.toString();
      }

      // Add image file
      if (uploadData.photo != null) {
        var byteData = await uploadData.photo!.readAsBytes();
        var multipartFile = http.MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: 'photo.jpg',
        );
        request.files.add(multipartFile);
      }

      // Set authorization header
      request.headers['Authorization'] = authToken;

      // Send the request
      var response = await request.send();

      var responseBody = await response.stream.bytesToString();
      UploadCeritaResponseModel uploadResponse =
      UploadCeritaResponseModel.fromJson(jsonDecode(responseBody));
      return uploadResponse;

    } catch (e) {
      rethrow;
    }
  }



// Future<UploadCeritaResponseModel> uploadCerita(UploadCeritaFormModel uploadData) async {
  //   try{
  //
  //     String authToken = await AuthService().getToken();
  //
  //     final res = await http.post(
  //         Uri.parse('$baseUrl/stories'),
  //         body: uploadData.toString(),
  //         headers: {
  //           'Content-Type': 'multipart/form-data',
  //           'Authorization' : authToken,
  //         }
  //     );
  //
  //     UploadCeritaResponseModel uploadResponse = UploadCeritaResponseModel.fromJson(jsonDecode(res.body));
  //
  //     return uploadResponse;
  //
  //   } catch(e) {
  //     rethrow;
  //   }
  // }
}