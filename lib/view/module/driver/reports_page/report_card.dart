import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class ReportTitle extends StatelessWidget {
  final String title;
  final String SubTitle;
  final String image;
  final Function() onPress;
  const ReportTitle({
    super.key,
    required this.title,
    required this.SubTitle,
    required this.image,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.boxColors),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.boxColors,
              child: SvgPicture.asset(image, height: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.medium18SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(
                    SubTitle,
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                ],
              ),
            ),

            SvgPicture.asset(SvgImage.arrow.value),
          ],
        ),
      ),
    );
  }
}
