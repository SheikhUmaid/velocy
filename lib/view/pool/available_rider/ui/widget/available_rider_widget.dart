import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/pool/available_rider/ui/widget/rider_card.dart';

class AvailableRiderWidget extends StatelessWidget {
  const AvailableRiderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),

                // Search field look-alike
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Chennai to Kashirnagar",
                            style: AppTextStyle.small14SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                              color: AppColors.appBlackColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SvgPicture.asset(SvgImage.search.value, height: 17),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Filter icon
                IconButton(
                  icon: SvgPicture.asset(SvgImage.filter.value, height: 17),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 4, // 1 for "Today" + 3 RideCards
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                'Today',
                style: AppTextStyle.medium18SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.rideDetails.value);
              },
              child: const RideCard(),
            );
          }
        },
      ),
    );
  }
}
