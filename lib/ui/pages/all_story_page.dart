import 'dart:math';

import 'package:ceritaku/controllers/list_cerita_controller.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:ceritaku/ui/pages/home_page.dart';
import 'package:ceritaku/ui/pages/story_detail_page.dart';
import 'package:ceritaku/ui/pages/story_map_page.dart';
import 'package:ceritaku/ui/pages/upload_cerita_page.dart';
import 'package:ceritaku/ui/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/methods.dart';
import '../../shared/theme.dart';

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
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: const Icon(Icons.arrow_back_sharp, size: 26),
        ),

        title: const Text('Cerita Kita'),

        actions: [
          GestureDetector(
            onTap: (){
              Get.to(() => const UploadCeritaPage());
            },
            child: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.add, size: 26),
            ),
          ),
        ],
      ),

      body: GetX(
        init: listCeritaStateController,
        builder: (controller){
          final isLoading = controller.isLoading.value;
          final listCeritaResponse = controller.listCeritaResponse;

          if(isLoading){
            return const Center(child: CircularProgressIndicator());
          }

          if(listCeritaResponse != null){
            final listCerita = listCeritaResponse.listCerita;

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: listCerita!.length,

              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.to(() => StoryDetailPage(storyId: listCerita[index].id.toString()));
                  },
                  child: AllCeritaCardCustom(
                      userName: listCerita[index].name.toString(),
                      ceritaDescription: listCerita[index].description.toString(),
                      ceritaImage: listCerita[index].photoUrl.toString(),
                      ceritaDate: formatDate(listCerita[index].createdAt.toString()),
                      ceritaPostTime: relativeTime(listCerita[index].createdAt.toString()),
                      userImage: profileImage[Random().nextInt(4)],
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),

      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        elevation: 0,
        color: whiteColor,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,

        child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            selectedItemColor: greenColor,
            unselectedItemColor: blackColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,

            selectedLabelStyle: greenTextStyle.copyWith(
                fontSize: 11,
                fontWeight: medium
            ),

            unselectedLabelStyle: blackTextStyle.copyWith(
                fontSize: 11,
                fontWeight: medium
            ),

            items: const [
              // Home
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),

              // Upload Cerita
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload_outlined),
                label: 'Upload Story',
              ),

              // All Cerita
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'All Stories',
              ),

              // Cerita Map
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Story Map',
              )
            ],

            currentIndex: 2,
            onTap: (index) {
              switch (index) {
                case 0:
                  Get.offAll(const HomePage());
                  break;

                case 1:
                  Get.offAll(const UploadCeritaPage());
                  break;

                case 2:
                  break;

                case 3:
                  listCeritaStateController.clearState();
                  Get.to(() => const StoryMapPage());
                  break;
              }
            }
        ),
      ),
    );
  }
}






























