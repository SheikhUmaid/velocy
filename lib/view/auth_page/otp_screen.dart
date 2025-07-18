import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/user/user_bottom_button.dart';
import 'package:velocy_user_app/widgets/my_textfield.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'OTP',
                    style: AppTextStyle.medium24SizeText.copyWith(
                      fontFamily: FontFamily.interBold,
                      fontSize: 23,
                    ),
                  ),
                  TextSpan(
                    text: '\t\t(one time password)',
                    style: AppTextStyle.small14SizeText.copyWith(
                      color: AppColors.appBlackColor,
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Enter your OTP send on your mobile no**",
              style: AppTextStyle.small14SizeText.copyWith(
                color: Color(0xFF808080),
                fontFamily: FontFamily.interRegular,
              ),
            ),
            const SizedBox(height: 26),
            _buildOtpField(),
            const SizedBox(height: 26),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "OTP",
          style: AppTextStyle.small14SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
        const SizedBox(height: 13),
        MyTextFormField(
          hintText: "Enter OTP",
          padding: const EdgeInsets.only(left: 13),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: SvgPicture.asset(SvgImage.eye.value),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return PrimaryButton(
      onPressed: () {
        Get.offAll(UserBottomButton(selectedInd: 0.obs));
      },
      text: "Login",
      style: AppTextStyle.small16SizeText.copyWith(
        fontFamily: FontFamily.interRegular,
        color: AppColors.appWhiteColor,
      ),
    );
  }
}
