import 'dart:math';

import 'package:ceritaku/controllers/list_cerita_controller.dart';
import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:ceritaku/ui/widgets/button_custom.dart';
import 'package:ceritaku/ui/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/methods.dart';

class AllStoryPage extends StatefulWidget {
  const AllStoryPage({super.key});

  @override
  State<AllStoryPage> createState() => _AllStoryPageState();
}

class _AllStoryPageState extends State<AllStoryPage> {
  final listCeritaStateController = Get.put(ListCeritaController());

  @override
  void initState() {
    super.initState();
    listCeritaStateController.fetchListCerita();
  }

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

      body: GetX(
        init: listCeritaStateController,
        builder: (controller){
          final isLoading = controller.isLoading.value;
          final listCeritaResponse = controller.listCeritaResponse;

          if(isLoading){
            return Center(child: CircularProgressIndicator());
          }

          if(listCeritaResponse != null){
            final listCerita = listCeritaResponse.listCerita;
            return ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: listCerita!.length,

              itemBuilder: (context, index){
                return AllCeritaCardCustom(
                    userName: listCerita[index].name.toString(),
                    ceritaDescription: listCerita[index].description.toString(),
                    ceritaImage: listCerita[index].photoUrl.toString(),
                    ceritaDate: '${formatDate(listCerita[index].createdAt.toString())}',
                    ceritaPostTime: '${relativeTime(listCerita[index].createdAt.toString())}',
                    userImage: profileImage[Random().nextInt(4)]
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}






























