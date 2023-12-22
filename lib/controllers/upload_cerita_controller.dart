import 'package:ceritaku/models/cerita/upload_cerita_form_model.dart';
import 'package:ceritaku/services/cerita_service.dart';
import 'package:get/get.dart';

class UploadCeritaController extends GetxController{
  var isLoading = false.obs;

  final _uploadCeritaResponse = Rxn<UploadCeritaResponseModel?>();
  UploadCeritaResponseModel? get uploadCeritaResponse => _uploadCeritaResponse.value;

  Future<bool> uploadCerita(UploadCeritaFormModel uploadData) async {
    isLoading(true);

    try{
      var uploadCerita = await CeritaService().uploadCerita(uploadData);
      _uploadCeritaResponse.value = uploadCerita;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      if(uploadCeritaResponse != null){
        if(uploadCeritaResponse!.error == false){
          isLoading(false);
          return true;

        } else {
          isLoading(false);
          return false;
        }
      }
    }

    return false;
  }

  clearState(){
    Get.delete<UploadCeritaController>(force: true);
  }
}