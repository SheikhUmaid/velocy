import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/driver_home_screen.dart';
import 'package:velocy_user_app/view/module/driver/recent_rides_page/recent_rides_screen.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/user_book_ride_screen.dart';
import 'package:velocy_user_app/view/module/user/user_coprate_page/user_coprate_screen.dart';
import 'package:velocy_user_app/view/module/user/user_pool_page/user_pool_screen.dart';
import 'package:velocy_user_app/view/module/user/user_rental_page/user_rental_screen.dart';

import 'reports_page/reports_screen.dart';

class DriverBottomButton extends StatelessWidget {
  DriverBottomButton({super.key, required this.selectedInd});

  final RxInt selectedInd;

  final RxList _children =
      [DriHomeScreen(), ReportScreen(), DriRecentRidesScreen()].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: AppColors.appWhiteColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.appWhiteColor,
            body: _children[(selectedInd.value)],
            bottomNavigationBar: Container(
              height: 62,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.appWhiteColor,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFE5E5E5),
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedInd(0);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          color:
                              selectedInd.value == 0
                                  ? AppColors.appBlackColor
                                  : AppColors.appGrayColor,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Home",
                          style: AppTextStyle.small12SizeText.copyWith(
                            fontFamily:
                                selectedInd.value == 0
                                    ? FontFamily.interSemiBold
                                    : FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      selectedInd(1);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          color:
                              selectedInd.value == 1
                                  ? AppColors.appBlackColor
                                  : AppColors.appGrayColor,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Reports",
                          style: AppTextStyle.small12SizeText.copyWith(
                            fontFamily:
                                selectedInd.value == 1
                                    ? FontFamily.interSemiBold
                                    : FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      selectedInd(2);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          color:
                              selectedInd.value == 2
                                  ? AppColors.appBlackColor
                                  : AppColors.appGrayColor,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Recent rides",
                          style: AppTextStyle.small12SizeText.copyWith(
                            fontFamily:
                                selectedInd.value == 2
                                    ? FontFamily.interSemiBold
                                    : FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
