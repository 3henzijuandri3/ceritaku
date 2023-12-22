import 'package:ceritaku/controllers/detail_cerita_controller.dart';
import 'package:ceritaku/shared/theme.dart';
import 'package:ceritaku/ui/widgets/mini_map_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

import '../../shared/methods.dart';

class StoryDetailPage extends StatefulWidget {
  final String storyId;

  const StoryDetailPage({Key? key, required this.storyId}) : super(key: key);

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  final detailStateController = Get.put(DetailCeritaController());

  @override
  void initState() {
    super.initState();
    detailStateController.fetchDetailCerita(widget.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
        color: Colors.black.withOpacity(0.7),

          child: GetX(
              init: detailStateController,
              builder: (controller){
                final isLoading = detailStateController.isLoading.value;
                final detailCeritaResponse = detailStateController.detailCeritaResponse;

                if(isLoading){
                  return const Center(child: CircularProgressIndicator());
                }

                if(detailCeritaResponse != null){
                  final detailCerita = detailCeritaResponse.detailCerita;

                  return NestedScrollView(
                    // Header Image
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          expandedHeight: MediaQuery.of(context).size.height * 0.4,
                          floating: false,
                          pinned: true,
                          backgroundColor: whiteColor,
                          leading: Container(),

                          flexibleSpace: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  detailCerita.photoUrl.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // Back Arrow
                              Positioned(
                                top: 10,
                                left: 10,
                                child: GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },

                                  child: Container(
                                    width: 30,
                                    height: 30,

                                    decoration: BoxDecoration(
                                        color: blackColor.withOpacity(0.45),
                                        shape: BoxShape.circle
                                    ),

                                    child: Center(
                                      child: Icon(Icons.arrow_back_rounded, size: 20, color: whiteColor),
                                    ),
                                  ),
                                ),
                              ),

                              // Post Duration
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                                  decoration: BoxDecoration(
                                      color: blackColor.withOpacity(0.45),
                                      borderRadius: BorderRadius.circular(14)
                                  ),

                                  child: Text(
                                    relativeTime(detailCerita.createdAt.toString()),
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: medium
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },

                    body: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      children: [

                        // User Profile
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            // User Name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Cerita Dari
                                Text(
                                  'Cerita Dari',
                                  style: GoogleFonts.oswald(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),

                                // User Name
                                SizedBox(
                                  width: 300,
                                  child: Text(
                                    detailCerita!.name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: blackTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: semiBold
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // User Image
                            Container(
                              width: 50,
                              height: 50,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: whiteColor, width: 3),
                                image: const DecorationImage(
                                  image: AssetImage('assets/img_friend4.png'),
                                ),
                              ),
                            )

                          ],
                        ),

                        const SizedBox(height: 8),

                        // Cerita Description
                        Text(
                          detailCerita.description.toString(),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Lokasi Cerita
                        Text(
                          'Lokasi Cerita',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        detailCerita.lat != null || detailCerita.lon != null
                            ?
                        SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: MiniMap(
                              lat: detailCerita.lat!.toDouble(),
                              long: detailCerita.lon!.toDouble(),
                              id: detailCerita.id.toString(),
                              name: detailCerita.name.toString()
                          ),
                        )
                            :
                        Container(
                            width: double.infinity,
                            height: 200,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],

                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: const AssetImage('assets/location_plaeholder.jpg'),
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.35),
                                      BlendMode.multiply
                                  )
                              ),
                            ),

                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  'Cerita ini tanpa lokasi',
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: semiBold
                                  ),
                                ),
                              ),
                            )
                        ),

                      ],
                    ),
                  );
                }
                return const Center(child: Text('Something Went Wrong :('));
            })
      ),
    );
  }
}
