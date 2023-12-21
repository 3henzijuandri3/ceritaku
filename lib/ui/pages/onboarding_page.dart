import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/ui/pages/register_page.dart';
import 'package:ceritaku/ui/widgets/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          // Background Image
          Image.asset(
            'assets/onboarding.jpg',
            fit: BoxFit.cover,
          ),

          // Black Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.transparent
                ],
              ),
            ),
          ),

          // Text
          Padding(
            padding: EdgeInsets.only(left: 24, bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Your Best Life\nWith Ceritaku',
                  style: whiteTextStyle.copyWith(
                    fontSize: 34,
                    fontWeight: bold
                  ),
                ),

                Text(
                  'Share your story anywhere',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: regular
                  ),
                ),

                const SizedBox(height: 50),

                FilledButtonCustom(
                    width: double.infinity,
                    height: 50,
                    label: 'Get Started',
                    onTap: (){
                      Get.to(() => const RegisterPage());
                    }
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
