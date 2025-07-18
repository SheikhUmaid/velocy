import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class RentalBoxWidget extends StatelessWidget {
  final Function() onPress;
  final String title;
  final String? icons;
  const RentalBoxWidget({
    super.key,
    required this.title,
    this.icons,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.boxColors,

          borderRadius: BorderRadius.circular(8),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...[
              icons != null ? SvgPicture.asset(icons!) : SizedBox.shrink(),
              SizedBox(width: 10),
            ],
            Text(
              title,
              style: AppTextStyle.medium18SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: AppColors.appBlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
