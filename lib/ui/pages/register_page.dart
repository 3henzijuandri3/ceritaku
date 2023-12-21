
import 'package:ceritaku/controllers/auth_controller.dart';
import 'package:ceritaku/models/auth/register_form_model.dart';
import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/ui/pages/login_page.dart';
import 'package:ceritaku/ui/widgets/button_custom.dart';
import 'package:ceritaku/ui/widgets/input_form_custom.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerStateController = Get.put(AuthController());

  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate(){
    if(nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty){
      return false;
    }
    return true;
  }

  register() async {
    if(validate()){
      final registerSuccess = await registerStateController.registerUser(
          RegisterFormModel(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text
          )
      );

      if(registerSuccess){
        if(!context.mounted) return;
        DInfo.dialogSuccess(context, 'Akun berhasil dibuat');
        DInfo.closeDialog(
          context,
          durationBeforeClose: const Duration(seconds: 1),
          actionAfterClose: (){
            registerStateController.clearState();
            registerStateController.clearState();
            Get.offAll(const LoginPage());
          }
        );

      } else {
        if(!context.mounted) return;
        final registerResponseMessage = registerStateController.registerResponse!.message.toString();
        DInfo.dialogError(context, registerResponseMessage);
      }

    } else {
      DInfo.snackBarError(context, 'Mohon isi semua field');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        final isLoading = registerStateController.isLoading.value;

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
                        image: AssetImage('assets/ceritaku_logo_auth.png'),
                      ),
                    ),
                  ),
                ),

                // Register Text
                Text(
                  'Create\nNew Account',
                  style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold
                  ),
                ),

                const SizedBox(height: 20),

                // User Name
                FilledInputCustom(
                  hintText: 'Name',
                  obscureText: false,
                  controller: nameController,
                ),

                const SizedBox(height: 16),

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
                    label: 'Sign Up',
                    onTap: () {
                      register();
                    }
                ),

                const SizedBox(height: 30),

                TextButtonCustom(
                    label: 'Sign In to My Account',
                    onTap: (){
                      Get.to(() => const LoginPage());
                    }
                ),
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
