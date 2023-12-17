import 'package:ceritaku/controllers/auth_controller.dart';
import 'package:ceritaku/models/register_form_model.dart';
import 'package:ceritaku/shared/methods.dart';
import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/ui/widgets/button_custom.dart';
import 'package:ceritaku/ui/widgets/input_form_custom.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
        init: registerStateController,

        builder: (controller) {
          final isLoading = controller.isLoading.value;
          final registerResponse = controller.registerResponse;

          if(isLoading){
            return const Center(child: CircularProgressIndicator());
          }



          return ListView(
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
                  onTap: (){
                    if(validate()){
                      controller.registerUser(
                        RegisterFormModel(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text
                        )
                      );

                    } else {
                      showCustomSnackbar(context, 'Mohon isi semua field');
                    }
                  }
              ),

              const SizedBox(height: 30),

              Text(registerResponse == null ? '' : registerResponse),
            ],
          );
        },
      ),
    );
  }
}
