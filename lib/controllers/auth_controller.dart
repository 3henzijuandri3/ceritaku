import 'package:ceritaku/models/register_form_model.dart';
import 'package:ceritaku/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  var isLoading = false.obs;

  final _registerResponse = Rxn<String?>();
  String? get registerResponse => _registerResponse.value;

  void registerUser(RegisterFormModel registerData) async {
    isLoading(true);

    try{
      var registerUser = await AuthService().register(registerData);
      _registerResponse.value = registerUser;

    } catch(e) {
      rethrow;

    } finally {
      isLoading(false);

    }

  }
}






























