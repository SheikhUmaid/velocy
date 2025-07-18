import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/driver_setting_page.dart';
import 'package:velocy_user_app/view/module/rental/rental_owner_profile/ui/widget/profile_widget.dart';
import 'package:velocy_user_app/view/notification/component/notification_button.dart';

class DriverArrivalScrrenWidget extends StatelessWidget {
  const DriverArrivalScrrenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 20),
        decoration: BoxDecoration(
          color: Color.fromRGBO(229, 231, 235, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(SvgImage.verify.value, height: 15),
            SizedBox(width: 4),
            Text(
              "Verify vehicle details before entering",
              style: AppTextStyle.small14SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: AppColors.appTextColors,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(AppImage.map.value),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.driverRoutePage.value);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.boxColors,

                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgImage.profile.value,
                          height: 64,
                          width: 64,
                        ),

                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Michael Johnson',
                                style: AppTextStyle.medium18SizeText.copyWith(
                                  fontFamily: FontFamily.interRegular,
                                ),
                              ),
                              SizedBox(height: 6),

                              Row(
                                children: [
                                  SvgPicture.asset(
                                    SvgImage.start.value,
                                    height: 16,
                                  ),
                                  SizedBox(width: 3),

                                  Text(
                                    '4.9',
                                    style: AppTextStyle.small14SizeText
                                        .copyWith(
                                          fontFamily: FontFamily.interRegular,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 9),

                        SvgPicture.asset(SvgImage.car.value, height: 16),
                        SizedBox(width: 6),

                        Text(
                          'Toyota Camry',
                          style: AppTextStyle.small14SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'ABC 123',
                          style: AppTextStyle.small14SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                            color: AppColors.appTextColors,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              // height: 60,
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
              decoration: BoxDecoration(
                color: Color.fromRGBO(38, 38, 38, 1),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Text(
                    "Your driver has arrived",
                    style: AppTextStyle.medium18SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appWhiteColor,
                    ),
                  ),
                  SizedBox(height: 6),

                  Text(
                    "Please proceed to the pickup location",
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            NotificationActionButton(
              title: 'Call Driver',
              icons: SvgImage.call.value,
              backgroungColors: Colors.black,
              colors: Colors.white,
            ),
            SizedBox(height: 10),
            PrimaryOutlinedButton(
              height: 60,
              title: 'Message Driver',
              onPressed: () {},
              radius: 12,
              icon: SvgPicture.asset(SvgImage.sendMessage.value),
              borderColor: AppColors.appBlackColor,
            ),
          ],
        ),
      ),
    );
  }
}
