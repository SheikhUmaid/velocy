import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/widgets/my_dropdown.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Dynamic list of available languages
  final List<String> languageList = [
    'English',
    'Hindi',
    'Marathi',
    'Gujarati',
    'Bengali',
    'Tamil',
    'Telugu',
  ];

  // Selected language
  String? selectedLanguage = "Select Language";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appBgColor,
      child: SafeArea(
        child: Scaffold(
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
              "Choose Language",
              style: AppTextStyle.medium18SizeText.copyWith(
                fontFamily: FontFamily.poppinsBold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome\nto VelocyTax",
                  style: AppTextStyle.extraLarge34SizeText.copyWith(
                    fontFamily: FontFamily.interBold,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Choose a language to get started",
                  style: AppTextStyle.medium18SizeText.copyWith(
                    fontFamily: FontFamily.inriaSansRegular,
                    color: const Color(0xFF9B9B9B),
                  ),
                ),
                const SizedBox(height: 36),
                MyDropDown(
                  array: languageList,
                  height: 48,
                  hintText: selectedLanguage,
                  onChange: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });

                    // Optional: Update app locale here
                    if (value == "Hindi") {
                      Get.updateLocale(Locale('hi', 'IN'));
                    } else if (value == "English") {
                      Get.updateLocale(Locale('en', 'US'));
                    }
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                height: 42,
                width: 132,
                onPressed: () {
                  if (selectedLanguage == null) {
                    Get.snackbar(
                      "Select Language",
                      "Please choose a language to continue.",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  Get.toNamed(Routes.authPage.value);
                },
                text: "Get Started",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
