import 'package:flutter/material.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class HeadingTitle extends StatelessWidget {
  const HeadingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Vehicle Information",
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          "Add Vehicle",
          style: AppTextStyle.small14SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            fontWeight: FontWeight.w400,
            color: AppColors.appTextColors,
          ),
        ),
      ],
    );
  }
}
