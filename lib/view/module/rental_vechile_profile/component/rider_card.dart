import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class RiderCard extends StatelessWidget {
  final String name;
  final String vehicleNumber;
  final String carModel;

  RiderCard({
    required this.name,
    required this.vehicleNumber,
    required this.carModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                // Placeholder for image/avatar
                SvgPicture.asset(SvgImage.profile.value, height: 60, width: 60),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        vehicleNumber,
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appTextColors,
                        ),
                      ),
                      Text(
                        carModel,
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
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey.shade300,
                      child: IconButton(
                        icon: SvgPicture.asset(SvgImage.phone.value),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey.shade300,
                      child: IconButton(
                        icon: SvgPicture.asset(SvgImage.circleMessage.value),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Reject",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Accept",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appBgColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
