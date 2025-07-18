import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';

import 'package:velocy_user_app/utils/text_styles.dart';

import '../../../../../../helper/routes_helper.dart';

class TripeCompleteWidget extends StatelessWidget {
  const TripeCompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),

            // Check Icon
            SvgPicture.asset(SvgImage.complete.value, height: 80, width: 80),

            SizedBox(height: 16),

            Text(
              "Trip Completed!",
              style: AppTextStyle.medium24SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),

            Text(
              "Earnings have been added to your wallet",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),

            SizedBox(height: 24),

            // Card with user and earnings
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        SvgImage.profile.value,
                        height: 48,
                        width: 48,
                      ),

                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sarah Passenger",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "4.95",
                                style: AppTextStyle.small16SizeText.copyWith(
                                  fontFamily: FontFamily.interRegular,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 32),

                  _buildFareRow("Trip Fare", "\$24.50"),
                  SizedBox(height: 6),

                  _buildFareRow("Platform Fee", "-\$4.90"),
                  SizedBox(height: 6),

                  _buildFareRow("Tips", "+\$5.00"),

                  Divider(height: 32),

                  _buildFareRow("Your Earnings", "\$24.60", isBold: true),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Stats Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat("Distance", "12.5 km"),
                  _buildStat("Duration", "25 min"),
                  _buildStat("Time", "13:45"),
                ],
              ),
            ),

            Spacer(),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.driverHomePage.value);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Start New Trip",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appBgColor,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFareRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.medium18SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              fontWeight: FontWeight.w500,
              color: AppColors.appBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ],
    );
  }
}
