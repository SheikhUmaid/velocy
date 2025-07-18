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

import 'package:flutter/material.dart';

class CoprateDashboard extends StatelessWidget {
  const CoprateDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBar(title: "Personal Account"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              SizedBox(height: 20),

              Text(
                "Company Ride Credits",
                style: AppTextStyle.medium22SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),

              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Balance",
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                            color: AppColors.appTextColors,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Monthly Limit",
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                            color: AppColors.appTextColors,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$2,450",
                          style: AppTextStyle.medium24SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "\$3,000",
                          style: AppTextStyle.medium18SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconButton(SvgImage.calendar.value, "Schedule Ride"),
                  _iconButton(SvgImage.report.value, "Ride Report"),
                ],
              ),

              const SizedBox(height: 24),
              Text(
                "Favourite",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.paymentScreen.value);
                },
                child: _iconTile(),
              ),

              const SizedBox(height: 35),
              Text(
                "Upcoming rides",
                style: AppTextStyle.medium18SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 16),
              _rideTile("Office → Airport", "Today, 2:30 PM", "\$45.00"),
              const SizedBox(height: 10),
              _rideTile("Home → Office", "Tomorrow, 9:15 AM", "\$32.50"),

              const SizedBox(height: 24),
              PrimaryButton(
                onPressed: () {},
                title: "Book Now",
                height: 52,
                radius: 12,
                color: AppColors.appBlackColor,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(String icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 17),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.boxColors),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          SvgPicture.asset(icon, height: 30),
          SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyle.small14SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 59,
              width: 70,
              padding: EdgeInsets.all(17.5),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.29),
                color: Color(0xFFE8E8E8),
              ),
              child: SvgPicture.asset(SvgImage.home.value),
            ),

            Text(
              "Home",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 59,
              width: 62.93,
              padding: EdgeInsets.all(17.5),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.29),
                color: Color(0xFFE8E8E8),
              ),
              child: SvgPicture.asset(SvgImage.office.value),
            ),

            Text(
              "Office",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 59,
              width: 62.93,
              padding: EdgeInsets.all(17.5),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.29),
                color: Color(0xFFE8E8E8),
              ),
              child: SvgPicture.asset(SvgImage.office.value),
            ),

            Text(
              "Office",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 59,
              width: 62.93,
              padding: EdgeInsets.all(17.5),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.29),
                color: Color(0xFFE8E8E8),
              ),
              child: SvgPicture.asset(SvgImage.airport.value),
            ),

            Text(
              "Airport",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _rideTile(String route, String time, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                route,
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  SvgPicture.asset(SvgImage.time2.value, height: 15),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            price,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildAppBar() {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      color: AppColors.appWhiteColor,
      // boxShadow: [
      //   BoxShadow(
      //     color: AppColors.appBlackColor.withOpacity(0.05),
      //     blurRadius: 2,
      //     offset: const Offset(0, 1),
      //   ),
      // ],
      border: Border(
        bottom: BorderSide(color: AppColors.appBlackColor.withOpacity(0.05)),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.unAuthorizedAcessPage.value);
          },
          child: SvgPicture.asset(SvgImage.profile.value, height: 32),
        ),
        const SizedBox(width: 22),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Account",
              style: AppTextStyle.small14SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
