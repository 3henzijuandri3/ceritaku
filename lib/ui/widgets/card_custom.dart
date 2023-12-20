import 'package:flutter/material.dart';

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
    required this.userImage
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

              SmallButtonCustom(
                  paddingX: 12,
                  paddingY: 6,
                  label: 'See more',
                  onTap: (){}
              ),
            ],
          ),
        ],
      ),
    );
  }
}
