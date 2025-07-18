import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class UnauthorizedAcessPage extends StatelessWidget {
  const UnauthorizedAcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(SvgImage.lock2.value, height: 60, width: 54),
              const SizedBox(height: 16),
              Text(
                'Unauthorized Access',
                style: AppTextStyle.medium24SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'You don’t have permission to view this corporate screen',
                textAlign: TextAlign.center,
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              Divider(height: 20),
              const SizedBox(height: 10),

              Text(
                'This area is restricted to corporate personnel only.',
                textAlign: TextAlign.center,
                style: AppTextStyle.small12SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                onPressed: () {},
                title: "Go Back",
                color: AppColors.appBlackColor,
                height: 48,
                radius: 8,
                icon: Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 16),
              PrimaryOutlinedButton(
                onPressed: () {},
                title: "Contact Support",
                borderColor: AppColors.boxColors,
                titleColor: AppColors.appBlackColor,
                height: 48,
                radius: 8,
                icon: Icon(Icons.question_mark),
              ),
              const SizedBox(height: 12),
              const Divider(),
              Text(
                'Need corporate access?',
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '© 2025 Company Name. All rights reserved.',
                style: AppTextStyle.small12SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '🔐 Security   |   ℹ️ Help',
                style: AppTextStyle.small12SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
