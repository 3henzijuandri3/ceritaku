import 'package:ceritaku/models/auth/login_form_model.dart';
import 'package:ceritaku/models/auth/login_response_model.dart';
import 'package:ceritaku/models/auth/register_form_model.dart';
import 'package:ceritaku/models/auth/register_response_model.dart';
import 'package:ceritaku/services/auth_service.dart';
import 'package:ceritaku/ui/pages/login_page.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  var isLoading = false.obs;

  final _registerResponse = Rxn<RegisterResponseModel?>();
  RegisterResponseModel? get registerResponse => _registerResponse.value;

  final _loginResponse = Rxn<LoginResponseModel?>();
  LoginResponseModel? get loginResponse => _loginResponse.value;

  Future<bool> registerUser(RegisterFormModel registerData) async {
    isLoading(true);

    try{
      var registerUser = await AuthService().register(registerData);
      _registerResponse.value = registerUser;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      if(registerResponse != null){
        if(registerResponse!.error == false){
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

  Future<bool> loginUser(LoginFormModel loginData) async {
    isLoading(true);

    try{
      var loginUser = await AuthService().login(loginData);
      _loginResponse.value = loginUser;

    } catch(e) {
      isLoading(false);
      rethrow;

    } finally {
      if(loginResponse != null){
        if(loginResponse!.error == false){
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
    Get.delete<AuthController>(force: true);
  }
}