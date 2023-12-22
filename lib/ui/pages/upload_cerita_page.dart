import 'dart:developer';
import 'dart:io';

import 'package:ceritaku/controllers/upload_cerita_controller.dart';
import 'package:ceritaku/models/cerita/upload_cerita_form_model.dart';
import 'package:ceritaku/shared/methods.dart';
import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/ui/pages/all_story_page.dart';
import 'package:ceritaku/ui/pages/story_map_page.dart';
import 'package:ceritaku/ui/widgets/button_custom.dart';
import 'package:ceritaku/ui/widgets/input_form_custom.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page.dart';

class UploadCeritaPage extends StatefulWidget {
  const UploadCeritaPage({super.key});

  @override
  State<UploadCeritaPage> createState() => _UploadCeritaPageState();
}

class _UploadCeritaPageState extends State<UploadCeritaPage> {
  final UploadCeritaController uploadStateController = Get.put(UploadCeritaController());
  final TextEditingController deskripsiController = TextEditingController(text: '');

  double? positionLat;
  double? positionLon;
  XFile? storyImage;

  void upload() async {
    if(validate()){
      final File imageFile = File(storyImage!.path);
      final File resizedImageFile = resizeImage(imageFile);


      final uploadSuccess = await uploadStateController.uploadCerita(
        UploadCeritaFormModel(
          description: deskripsiController.text,
          lat: positionLat,
          lon: positionLon,
          photo: resizedImageFile
        )
      );

      if(uploadSuccess){
        if(!context.mounted) return;
        DInfo.dialogSuccess(context, 'Upload berhasil');
        DInfo.closeDialog(
            context,
            durationBeforeClose: const Duration(seconds: 1),
            actionAfterClose: (){
              Get.offAll(const HomePage());
            }
        );

      } else {
        if(!context.mounted) return;
        final uploadResponseMessage = uploadStateController.uploadCeritaResponse!.message.toString();
        log(uploadResponseMessage.toString());
        DInfo.dialogError(context, uploadResponseMessage);
      }

    } else {
      DInfo.snackBarError(context, 'Mohon isi field yang dibutuhkan');
    }
  }

  bool validate(){
    if(deskripsiController.text.isEmpty || storyImage == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        final isLoading = uploadStateController.isLoading.value;

        return SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [

                  // Image
                  storyImage == null
                      ?
                  Container(
                    width: double.infinity,
                    height: 280,

                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image:  AssetImage('assets/upload.png'),
                      ),
                    ),
                  )
                      :
                  Container(
                    width: double.infinity,
                    height: 280,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(File(storyImage!.path)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Pick Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // From Camera
                      GestureDetector(
                        onTap: () async {
                          final image = await selectImageCamera();
                          storyImage= image;
                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 150,

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: whiteColor
                          ),

                          child: Center(
                            child: Icon(Icons.add_a_photo_rounded, size: 60, color: greenColor),
                          ),
                        ),
                      ),

                      // From Gallery
                      GestureDetector(
                        onTap: () async {
                          final image = await selectImageGallery();
                          storyImage = image;
                          setState(() {});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 150,

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: whiteColor
                          ),

                          child: Center(
                            child: Icon(Icons.add_photo_alternate, size: 60, color: greenColor),
                          ),
                        ),
                      )

                    ],
                  ),

                  const SizedBox(height: 20),

                  // Story Description
                  BigBorderInputCustom(
                    formHint: 'Deskripsi Cerita',
                    controller: deskripsiController,
                  ),

                  const SizedBox(height: 14),

                  // Location
                  GestureDetector(
                    onTap: (){
                      getStoryLocation();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,

                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: greenColor,
                              width: 1
                          )
                      ),

                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            positionLat == null || positionLon == null
                                ? 'Tap to get location (Optional)' : 'lat: $positionLat, lon: $positionLon',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunitoSans(
                                color: greyColor,
                                fontSize: 16,
                                fontWeight: regular
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  FilledButtonCustom(
                      width: double.infinity,
                      height: 50,
                      label: 'Upload',
                      onTap: (){
                        upload();
                      }
                  ),

                  const SizedBox(height: 20)
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
          ),
        );
      }),

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

            currentIndex: 1,
            onTap: (index) {
              switch (index) {
                case 0:
                  Get.offAll(const HomePage());
                  break;

                case 1:
                  break;

                case 2:
                  Get.offAll(const AllStoryPage());
                  break;

                case 3:
                  Get.to(() => const StoryMapPage());
                  break;
              }
            }
        ),
      ),
    );
  }

  Future<void> getStoryLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error('Location permissions are permanently denied');
    }

    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    positionLat = position.latitude;
    positionLon = position.longitude;
    setState(() {});
  }
}
