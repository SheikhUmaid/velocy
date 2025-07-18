import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final RxList<String> onboardingImage =
      [
        AppImage.onBoarding.value,
        AppImage.onBoarding.value,
        AppImage.onBoarding.value,
      ].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          backgroundColor: AppColors.appBgColor,
          body: Column(
            children: [
              Expanded(
                child:
                    PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      itemCount: onboardingImage.length,
                      onPageChanged: (index) {
                        currentPage.value = index;
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(onboardingImage[index], fit: BoxFit.cover),
                            Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                      (onboardingImage.length), (index) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 2, right: 2),
                                      child: Container(
                                        height: 7,
                                        width: index == currentPage.value ? 28 :9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: index == currentPage.value
                                                ? AppColors.appWhiteColor
                                                : Color(0xFFE7E7E7),
                                          ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
              ),
              SizedBox(
                height: 228,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to VelocyTax",
                      style: AppTextStyle.large28SizeText.copyWith(
                        color: AppColors.appBlackColor,
                        fontFamily: FontFamily.poppinsBold,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      "You've successfully registered!",
                      style: AppTextStyle.small14SizeText.copyWith(
                        color: const Color(0xff6F6F6F),
                        fontFamily: FontFamily.poppinsRegular,
                        letterSpacing: -1,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.appWhiteColor,
                            AppColors.appBlackColor,
                            AppColors.appWhiteColor,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                           'To offer rides as a driver',
                          style: AppTextStyle.small14SizeText.copyWith(
                            color: const Color(0xff555555),
                            fontFamily: FontFamily.poppinsRegular,
                            letterSpacing: -1,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.driverRegistrationPage.value);

                          },
                          child: Text(
                          '\t\tClick here.',
                            style: AppTextStyle.small14SizeText.copyWith(
                              color: AppColors.appBlackColor,
                              fontFamily: FontFamily.poppinsSemiBold,
                              letterSpacing: -1,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 26),
                    PrimaryButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.authPage.value);
                      },
                      text: "Get Started",
                      height: 42,
                      width: 132,
                    ),
                    SizedBox(height: 26),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
