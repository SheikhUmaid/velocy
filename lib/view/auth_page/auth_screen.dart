import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/auth_page/components/login_screen.dart';
import 'package:velocy_user_app/view/auth_page/components/register_screen.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final RxInt selectLogin = 0.obs;

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
            "Velocy",
            style: AppTextStyle.medium18SizeText.copyWith(
              fontFamily: FontFamily.poppinsBold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                Container(
                  height: 48,
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(bottom: 36),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectLogin.value = 0;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  selectLogin.value == 0
                                      ? Color(0xFFFFFFFF)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Login",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectLogin.value = 1;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  selectLogin.value == 1
                                      ? Color(0xFFFFFFFF)
                                      : Colors.transparent,

                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Register",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                selectLogin.value == 0 ? LoginScreen() : RegisterScreen(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
