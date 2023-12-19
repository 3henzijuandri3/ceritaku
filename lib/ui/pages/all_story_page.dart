import 'dart:math';

import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:ceritaku/ui/widgets/button_custom.dart';
import 'package:ceritaku/ui/widgets/card_custom.dart';
import 'package:flutter/material.dart';

class AllStoryPage extends StatefulWidget {
  const AllStoryPage({super.key});

  @override
  State<AllStoryPage> createState() => _AllStoryPageState();
}

class _AllStoryPageState extends State<AllStoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_sharp, size: 26),

        title: const Text('Cerita Kita'),

        actions: const [
          Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.add, size: 26),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),

        children:  [

          // Story Card
          AllCeritaCardCustom(
              userName: 'Henzi',
              ceritaDescription: 'Bagus banget nih tempat. The best!!!',
              ceritaImage: 'assets/cerita_placeholder.png',
              ceritaDate: '20-12-2023',
              ceritaPostTime: '10m',
              userImage: profileImage[Random().nextInt(4)]
          ),

          AllCeritaCardCustom(
              userName: 'Kevin',
              ceritaDescription: 'Gandum segar hasil panen',
              ceritaImage: 'assets/gandum.png',
              ceritaDate: '20-12-2023',
              ceritaPostTime: '50m',
              userImage: profileImage[Random().nextInt(4)]
          ),

          AllCeritaCardCustom(
              userName: 'Kevin',
              ceritaDescription: 'Gandum segar hasil panen',
              ceritaImage: 'assets/cerita_placeholder.png',
              ceritaDate: '20-12-2023',
              ceritaPostTime: '50m',
              userImage: profileImage[Random().nextInt(4)]
          ),

        ],
      ),
    );
  }
}






























