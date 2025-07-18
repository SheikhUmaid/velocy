import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/ride_sechedule/ui/widget/cancel_widget.dart';
import 'package:velocy_user_app/view/module/driver/ride_sechedule/ui/widget/history_widget.dart';
import 'package:velocy_user_app/view/module/driver/ride_sechedule/ui/widget/schedule_widget.dart';

class RideSechedulePage extends StatelessWidget {
  RideSechedulePage({super.key});

  final RxInt history = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.appBgColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBgColor,
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.appBlackColor,
              size: 24,
            ),
          ),
          title: Text(
            "My Rides",
            style: AppTextStyle.medium18SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 47,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 4),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.appWhiteColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.appGrayColorE5,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        history.value = 0;
                      },
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  history.value == 0
                                      ? AppColors.appBlackColor
                                      : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          "Cancelled",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.small14SizeText.copyWith(
                            color:
                                history.value == 0
                                    ? AppColors.appBlackColor
                                    : AppColors.appDarkGrayColor73,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        history.value = 1;
                      },
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  history.value == 1
                                      ? AppColors.appBlackColor
                                      : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          "Scheduled",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.small14SizeText.copyWith(
                            color:
                                history.value == 1
                                    ? AppColors.appBlackColor
                                    : AppColors.appDarkGrayColor73,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        history.value = 2;
                      },
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  history.value == 2
                                      ? AppColors.appBlackColor
                                      : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          "Cancelled",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.small14SizeText.copyWith(
                            color:
                                history.value == 2
                                    ? AppColors.appBlackColor
                                    : AppColors.appDarkGrayColor73,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            history.value == 0
                ? HistoryWidget()
                : history.value == 1
                ? ScheduledWidget()
                : CancelledWidget(),
          ],
        ),
      );
    });
  }
}
