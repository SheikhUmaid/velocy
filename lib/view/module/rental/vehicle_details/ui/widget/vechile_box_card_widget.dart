import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class VehicleFeatureCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icons;
  const VehicleFeatureCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 231, 235, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromRGBO(229, 231, 235, 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icons, height: 17),
          SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              SizedBox(height: 5),
              Text(
                subTitle,
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
