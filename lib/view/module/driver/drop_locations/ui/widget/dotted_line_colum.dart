import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class PickupDropDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(SvgImage.round.value),

            // Dotted Line
            Dash(
              direction: Axis.vertical,
              length: 20,
              dashLength: 9,
              dashColor: AppColors.appBlackColor,
            ),

            // Bottom Icon (Drop-off)
            SvgPicture.asset(SvgImage.location.value),
          ],
        ),

        // Right Side Texts
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pick-up",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              Text(
                "123 Main Street, Downtown",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Drop-off",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              Text(
                "456 Park Avenue, Uptown",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
        ),

        // Optional: Check Icon
        Column(
          children: [Icon(Icons.check_circle, size: 20, color: Colors.black)],
        ),
      ],
    );
  }
}
