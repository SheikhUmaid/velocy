import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class ScheduledWidget extends StatelessWidget {
  const ScheduledWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.rideDetailsPage.value);
            },
            child: Container(
              height: 139,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.appWhiteColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.appBlackColor.withOpacity(0.10),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today, 10:30 AM",
                        style: AppTextStyle.small14SizeText.copyWith(
                          color: AppColors.appDarkGrayColor73,
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),

                      Text(
                        "\$24.50",
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 64,
                        margin: EdgeInsets.only(top: 13),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              SvgImage.location.value,
                              colorFilter: ColorFilter.mode(
                                Color(0xFFA3A3A3),
                                BlendMode.srcIn,
                              ),
                              height: 18,
                            ),
                            SizedBox(width: 16),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "123 Main Street, Downtown",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                ),
                                Container(
                                  height: 16,
                                  margin: EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: AppColors.appTextGrayColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "456 Park Avenue, Uptown",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: PrimaryButton(
                          height: 30,
                          width: 80,
                          onPressed: () {},
                          text: "Cancel",
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                            color: AppColors.appWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
