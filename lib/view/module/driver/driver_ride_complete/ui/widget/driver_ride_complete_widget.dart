import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class DriverRideCompleteWidget extends StatelessWidget {
  const DriverRideCompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Ride Complete", centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ride Info
            Row(
              children: [
                SvgPicture.asset(SvgImage.profile.value, height: 48),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John's Ride",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                    Text(
                      "Toyota Camry • ABC 123",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appTextColors,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                SvgPicture.asset(SvgImage.time.value),
                // Icon(Icons.access_time, size: 18),
                SizedBox(width: 8),
                Text(
                  "Today, 2:30 PM • 25 min",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: AppColors.appTextColors,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                SvgPicture.asset(SvgImage.round.value, height: 12),
                SizedBox(width: 8),
                Text(
                  "123 Start Street",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset(SvgImage.locations.value, height: 12),
                SizedBox(width: 4),
                Text(
                  "456 End Avenue",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            SizedBox(height: 20),
            // Fare Breakdown
            Text(
              "Fare Breakdown",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            const SizedBox(height: 5),
            _fareRow("Base fare", "\$12.50"),
            const SizedBox(height: 5),
            _fareRow("Distance (5.2 mi)", "\$8.30"),
            const SizedBox(height: 5),
            _fareRow("Time (25 min)", "\$6.20"),
            const SizedBox(height: 5),
            const Divider(),
            _fareRow("Total", "\$27.00", isBold: true),

            const SizedBox(height: 345),
            PrimaryButton(
              onPressed: () {
                Get.toNamed(Routes.tripeCompletePage.value);
              },
              title: "Done",
              height: 56,
              color: AppColors.appBlackColor,
              radius: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fareRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
