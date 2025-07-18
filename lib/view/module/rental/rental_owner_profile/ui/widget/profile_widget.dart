import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
    
     Row(
      children: [
        SvgPicture.asset(SvgImage.profile.value, height: 67, width: 65),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John',
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              SizedBox(height: 3),

              Text(
                'KA 01 AB 1234',
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Toyota Camry – Silver',
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(229, 231, 235, 1),
              ),
              child: SvgPicture.asset(SvgImage.call.value),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(229, 231, 235, 1),
              ),
              child: SvgPicture.asset(SvgImage.circleMessage.value),
            ),
          ],
        ),
      ],
    );
  
  }
}
