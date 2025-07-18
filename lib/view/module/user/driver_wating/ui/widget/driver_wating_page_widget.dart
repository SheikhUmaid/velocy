import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class DriverWaitingPage extends StatelessWidget {
  const DriverWaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Waiting for driver"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(AppImage.map3.value),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(SvgImage.wating.value, height: 74),
                  const SizedBox(height: 12),
                  Text(
                    "Waiting for driver...",
                    style: AppTextStyle.extraLarge32SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please wait a few seconds while we connect you with a driver.",
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    onPressed: () {
                      Get.toNamed(Routes.liveTrackingsPage.value);
                    },
                    title: "Cancel Ride",
                    height: 48,
                    radius: 8,
                    color: AppColors.appTextGrayColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
