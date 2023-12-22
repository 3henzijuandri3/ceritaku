
import 'package:ceritaku/services/auth_service.dart';
import 'package:ceritaku/ui/pages/home_page.dart';
import 'package:ceritaku/ui/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  Future<void> checkUserLoginStatus() async {
    String token = await authService.getToken();
    bool isLoggedIn = token.isNotEmpty;

    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {
      Get.off(() => const HomePage());
    } else {
      Get.off(() => const OnBoardingPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/ceritaku_logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
