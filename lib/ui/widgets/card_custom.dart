import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/theme.dart';
import 'button_custom.dart';

class AllCeritaCardCustom extends StatelessWidget {
  final String userName;
  final String ceritaDescription;
  final String ceritaImage;
  final String ceritaDate;
  final String ceritaPostTime;
  final String userImage;

  const AllCeritaCardCustom({
    super.key,
    required this.userName,
    required this.ceritaDescription,
    required this.ceritaImage,
    required this.ceritaDate,
    required this.ceritaPostTime,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Top Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // User Profile Image
              Container(
                width: 55,
                height: 55,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(userImage),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Name & Story Description
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Name and Time
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // User Name
                          SizedBox(
                            width: 180,
                            child: Text(
                              userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: semiBold
                              ),
                            ),
                          ),

                          // Time
                          Text(
                            ceritaPostTime,
                            style: greyTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: medium
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 3),

                    // Description
                    SizedBox(
                      width: 270,
                      child: Text(
                        ceritaDescription,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium
                        ),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),

          const SizedBox(height: 16),

          // Image Section
          Container(
            width: double.infinity,
            height: 200,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(ceritaImage),
                  // colorFilter: ColorFilter.mode(
                  //     Colors.black.withOpacity(0.35),
                  //     BlendMode.multiply
                  // )
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Bottom Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: greyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)
                  ),

                  child: Row(
                    children: [
                      Icon(Icons.calendar_month, color: redColor),

                      const SizedBox(width: 8),

                      Text(
                        ceritaDate,
                        style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SmallButtonCustom(
                  paddingX: 12,
                  paddingY: 6,
                  label: 'See more',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LatestCeritaCardCustom extends StatelessWidget {
  final String description;
  final String imageUrl;
  final String userImage;
  final String userName;

  const LatestCeritaCardCustom({
    super.key,
    required this.description,
    required this.imageUrl,
    required this.userImage,
    required this.userName
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      margin: const EdgeInsets.only(right: 20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.multiply
          )
        ),
      ),

      // Story Information
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Story Description
            Text(
              description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: medium
              ),
            ),

            const SizedBox(height: 14),

            // User Information
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // User Image
                Container(
                  width: 35,
                  height: 35,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(userImage)
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // User Name
                SizedBox(
                  width: 180,
                  child: Text(
                    userName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      )
    );
  }
}

class TipsCardCustom extends StatelessWidget {

  final String tips;
  final String imgUrl;
  final String urlWeb;

  const TipsCardCustom({Key? key, required this.tips, required this.imgUrl, required this.urlWeb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  {
        launchUrl(Uri.parse(urlWeb));
      },

      child: Container(
        width: 155,
        height: 176,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
        ),

        child: Column(
          children: [

            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.asset(
                imgUrl,
                width: 155,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),


            const SizedBox(
              height: 12,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                tips,
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}