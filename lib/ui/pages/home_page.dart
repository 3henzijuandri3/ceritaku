import 'dart:math';

import 'package:ceritaku/controllers/list_cerita_controller.dart';
import 'package:ceritaku/models/cerita/list_cerita_model.dart';
import 'package:ceritaku/services/auth_service.dart';
import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/shared/value.dart';
import 'package:ceritaku/ui/pages/all_story_page.dart';
import 'package:ceritaku/ui/pages/onboarding_page.dart';
import 'package:ceritaku/ui/pages/story_detail_page.dart';
import 'package:ceritaku/ui/pages/story_map_page.dart';
import 'package:ceritaku/ui/pages/upload_cerita_page.dart';
import 'package:ceritaku/ui/widgets/button_custom.dart';
import 'package:ceritaku/ui/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeStateController = Get.put(ListCeritaController());

  @override
  void initState() {
    super.initState();
    homeStateController.fetchCeritaHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: GetX(
            init: homeStateController,
            builder: (controller){
              final isLoading = homeStateController.isLoading.value;
              final profileName = homeStateController.userName;
              final listCeritaResponse = homeStateController.listCeritaResponse;

              if(isLoading){
                return const Center(child: CircularProgressIndicator());
              }

              if(listCeritaResponse != null && profileName != null){
                final listCerita = listCeritaResponse.listCerita;

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [

                    // Name and Profile
                    profileSection(profileName),

                    const SizedBox(height: 32),

                    // Map Container
                    mapContainer(),

                    const SizedBox(height: 30),

                    // Option Menu
                    optionMenu(),

                    const SizedBox(height: 30),

                    // Latest Story
                    latestStory(listCerita!),

                    const SizedBox(height: 30),

                    // Productivity Tips
                    productiveTips()
                  ],
                );
              }

              return const Center(child: Text('Something Went Wrong :('));
            }),
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

            currentIndex: 0,
            onTap: (index) {
              switch (index) {
                case 0:
                  break;

                case 1:
                  Get.offAll(const UploadCeritaPage());
                  break;

                case 2:
                  Get.offAll(const AllStoryPage());
                  break;

                case 3:
                  homeStateController.clearState();
                  Get.to(() => const StoryMapPage());
                  break;
              }
          }
        ),
      ),
    );
  }

  Widget profileSection(String username){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Howdy',
              style: greyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular
              ),
            ),

            Text(
              username,
              style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold
              ),
            ),
          ],
        ),

        // Profile
        GestureDetector(
          onTap: (){
            showDialog(context: context, builder: (context) => const MoreDialog());
          },

          child: Container(
            width: 60,
            height: 60,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/img_friend4.png'),
              ),
            ),
          ),
        )

      ],
    );
  }

  Widget mapContainer(){
    return Container(
      width: double.infinity,
      height: 230,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: const AssetImage('assets/maps.jpg'),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply
            )
        ),
      ),

      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'See Stories Across The World',
                style: whiteTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: (){
                  homeStateController.clearState();
                  Get.to(() => const StoryMapPage());
                },
                child: const SmallButtonCustom(paddingX: 16, paddingY: 10, label: 'Open Map'),
              )
            ],
          )
      ),
    );
  }

  Widget optionMenu(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Do Something',
          style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold
          ),
        ),

        const SizedBox(height: 14),

        // Option Menu
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MenuButtonCutom(
                icon: Icons.camera_front_outlined,
                label: 'All Stories',
                onTap: (){
                  homeStateController.clearState();
                  Get.to(() => const AllStoryPage());
                }
            ),

            MenuButtonCutom(
                icon: Icons.cloud_upload_outlined,
                label: 'Upload Story',
                onTap: (){
                  homeStateController.clearState();
                  Get.to(() => const UploadCeritaPage());
                }
            ),

            MenuButtonCutom(
                icon: Icons.map,
                label: 'Story Map',
                onTap: (){
                  homeStateController.clearState();
                  Get.to(() => const StoryMapPage());
                }
            ),
          ],
        ),
      ],
    );
  }

  Widget latestStory(List<CeritaModel> listCerita){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Story',
          style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold
          ),
        ),

        const SizedBox(height: 14),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: listCerita.map((cerita) =>
                GestureDetector(
                  onTap: (){
                    Get.to(() => StoryDetailPage(storyId: cerita.id.toString()));
                  },
                  child: LatestCeritaCardCustom(
                      description: cerita.description.toString(),
                      imageUrl: cerita.photoUrl.toString(),
                      userImage: profileImage[Random().nextInt(4)],
                      userName: cerita.name.toString()
                  ),
                )
            ).take(5).toList(),
          ),
        ),
      ],
    );
  }

  Widget productiveTips(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Cooking Tips
        Text(
          'Productivity Tips',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),

        const SizedBox(height: 14),

        const Wrap(
          spacing: 20,
          runSpacing: 20,

          children: [
            TipsCardCustom(
                tips: '20 Productivity Tips',
                imgUrl: 'assets/tips1.png',
                urlWeb: 'https://hive.com/blog/productivity-tips/'
            ),

            TipsCardCustom(
                tips: 'Boost Your Productivity',
                imgUrl: 'assets/tips2.jpg',
                urlWeb: 'https://www.atlassian.com/blog/productivity/simple-ways-to-be-productive-at-work'
            ),

            TipsCardCustom(
                tips: 'Productivity Startegies',
                imgUrl: 'assets/tips3.png',
                urlWeb: 'https://jamesclear.com/productivity'
            ),

            TipsCardCustom(
                tips: 'Productivity 101',
                imgUrl: 'assets/tips4.png',
                urlWeb: 'https://www.betterup.com/blog/what-is-productivity'
            ),
          ],
        ),

      ],
    );
  }
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,

      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 180,
        
        decoration: BoxDecoration(
          color: lightBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text
            Text(
              'Do you want to Logout?',
              style: blackTextStyle.copyWith(
                fontSize: 22,
                fontWeight: semiBold
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },

              child: Text(
                'No',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium
                ),
              ),
            ),

            const SizedBox(height: 14),

            GestureDetector(
              onTap: (){
                AuthService().clearLocalStorage();
                Get.offAll(() => const OnBoardingPage());
              },
              child: const SmallButtonCustom(paddingX: 18, paddingY: 8, label: 'Yes', customFontSize: 16),
            ),
            
          ],
        ),
      ),
    );
  }
}