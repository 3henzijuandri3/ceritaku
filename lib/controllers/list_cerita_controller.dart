import 'package:ceritaku/models/auth/list_cerita_model.dart';
import 'package:ceritaku/services/cerita_service.dart';
import 'package:get/get.dart';

class ListCeritaController extends GetxController{
  var isLoading = false.obs;

  final _listCeritaResponse = Rxn<ListCeritaModel?>();
  ListCeritaModel? get listCeritaResponse => _listCeritaResponse.value;

  Future<void> fetchListCerita() async {
    isLoading(true);
    String authToken = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ1c2VyLVRXZy1BWElJemdNd0pFWk4iLCJpYXQiOjE3MDI5NzcyNjd9.QK9CipKCa3xUyIYo2Be-hTHpEca52ci4MH6tCgU1Hns';

    try{
      var getListCerita = await CeritaService().getListCerita(authToken);
      _listCeritaResponse.value = getListCerita;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

}