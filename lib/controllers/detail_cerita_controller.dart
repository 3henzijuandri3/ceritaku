import 'package:ceritaku/models/cerita/cerita_detail_model.dart';
import 'package:ceritaku/services/cerita_service.dart';
import 'package:get/get.dart';

class DetailCeritaController extends GetxController{
  var isLoading = false.obs;

  final _detailCeritaResponse = Rxn<CeritaDetailModel?>();
  CeritaDetailModel? get detailCeritaResponse => _detailCeritaResponse.value;

  Future<void> fetchDetailCerita(String id) async {
    isLoading(true);

    try{
      var getDetailCerita = await CeritaService().getCeritaDetail(id);
      _detailCeritaResponse.value = getDetailCerita;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      isLoading(false);
    }
  }

}