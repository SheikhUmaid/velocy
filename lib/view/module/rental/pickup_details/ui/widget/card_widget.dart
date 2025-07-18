import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String image;
  const CardWidget({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(229, 231, 235, 1)),

        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(image, height: 20, width: 19),
          SizedBox(width: 10),
          Text(
            title,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              color: AppColors.appBlackColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
