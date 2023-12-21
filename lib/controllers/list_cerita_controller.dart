import 'package:ceritaku/models/cerita/list_cerita_model.dart';
import 'package:ceritaku/services/auth_service.dart';
import 'package:ceritaku/services/cerita_service.dart';
import 'package:get/get.dart';

class ListCeritaController extends GetxController{
  var isLoading = false.obs;

  final _listCeritaResponse = Rxn<ListCeritaModel?>();
  ListCeritaModel? get listCeritaResponse => _listCeritaResponse.value;

  final _userName = Rxn<String?>();
  String? get userName => _userName.value;

  Future<void> fetchListCerita() async {
    isLoading(true);

    try{
      var getListCerita = await CeritaService().getListCerita();
      _listCeritaResponse.value = getListCerita;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCeritaHome() async {
    isLoading(true);

    try{
      var getListCerita = await CeritaService().getListCerita();
      _listCeritaResponse.value = getListCerita;

      var getUserName = await AuthService().getUserName();
      _userName.value = getUserName;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

  clearState(){
    Get.delete<ListCeritaController>(force: true);
  }

}