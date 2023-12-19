import 'package:ceritaku/shared/theme.dart';
import 'package:flutter/material.dart';

class AllStoryPage extends StatelessWidget {
  const AllStoryPage({super.key});

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
        padding: const EdgeInsets.all(14),

        children:  [

          // Story Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              children: [

                // Top Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // User Profile Image
                    Container(
                      width: 50,
                      height: 50,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/user_placeholder.png')
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // User Name
                    Text(
                      'Andy',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '20m ago',
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 14),

                // Image Section
                Container(
                  width: double.infinity,
                  height: 200,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/cerita_placeholder.png'),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Description Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    'Pemandangan Lake Como di Italia pada malam hari, serasa seperti di surga. Bagus banget!!!',
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: medium
                    ),
                  ),
                ),

                const SizedBox(height: 14),



              ],
            ),
          ),

        ],
      ),
    );
  }
}






























