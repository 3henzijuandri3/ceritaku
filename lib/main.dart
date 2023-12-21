import 'dart:convert';

import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/ui/pages/splash_screen_page.dart';
import 'package:ceritaku/ui/pages/story_map_page.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroundColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: lightBackgroundColor,

            iconTheme: IconThemeData(
              color: blackColor,
            ),

            titleTextStyle: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold
            ),
          )
      ),

      home: const SplashScreenPage(),
    );
  }
}