import 'package:ceritaku/models/auth/login_form_model.dart';
import 'package:ceritaku/ui/pages/register_page.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../shared/theme.dart';
import '../widgets/button_custom.dart';
import '../widgets/input_form_custom.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginStateController = Get.put(AuthController());

  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate(){
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      return false;
    }
    return true;
  }

  login() async {
    if(validate()){
      final loginSuccess = await loginStateController.loginUser(
          LoginFormModel(
              email: emailController.text,
              password: passwordController.text
          )
      );

      if(loginSuccess){
        if(!context.mounted) return;
        DInfo.dialogSuccess(context, 'Login berhasil');
        // DInfo.closeDialog(
        //     context,
        //     durationBeforeClose: const Duration(seconds: 1),
        //     actionAfterClose: (){
        //       Get.offAll(const LoginPage());
        //     }
        // );

      } else {
        if(!context.mounted) return;
        final loginResponseMessage = loginStateController.loginResponse!.message.toString();
        DInfo.dialogError(context, loginResponseMessage);
      }

    } else {
      DInfo.snackBarError(context, 'Mohon isi semua field');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        final isLoading = loginStateController.isLoading.value;
        final loginResponse = loginStateController.loginResponse;

        return Stack(
          children: [
            // Register Form
            ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Logo Aplikasi
                Center(
                  child: Container(
                    height: 300,

                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/ceritaku_logo.png'),
                      ),
                    ),
                  ),
                ),

                // Register Text
                Text(
                  'Sign In\nTo Your Account',
                  style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold
                  ),
                ),

                const SizedBox(height: 20),

                // User Email
                FilledInputCustom(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),

                const SizedBox(height: 16),

                // User Password
                FilledInputCustom(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),

                const SizedBox(height: 30),

                // Button Sign Up
                FilledButtonCustom(
                    width: double.infinity,
                    height: 50,
                    label: 'Sign In',
                    onTap: () {
                      login();
                    }
                ),

                const SizedBox(height: 30),

                TextButtonCustom(
                    label: 'Create a New Account',
                    onTap: (){
                      Get.to(() => const RegisterPage());
                    }
                ),

                const SizedBox(height: 30),

                Text(loginResponse != null ? loginResponse.loginResult!.token.toString() : ''),
              ],
            ),

            // Loading Bar
            if(isLoading)
              Stack(
                children: [
                  // Overlay
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.2),
                  ),

                  // Circular Bar
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
          ],
        );
      })
    );
  }
}
