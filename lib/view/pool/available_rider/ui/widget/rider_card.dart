import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class RideCard extends StatelessWidget {
  const RideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.boxColors),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Time and Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(SvgImage.time2.value, height: 16),
                    SizedBox(width: 9),
                    Text(
                      "4:00 PM - 10:00 PM",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                  ],
                ),
                Text(
                  "₹150/seat",
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Route
            Row(
              children: [
                SvgPicture.asset(SvgImage.locations.value, height: 16),
                SizedBox(width: 6),
                Text(
                  "Chennai → Kashirnagar",
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Driver Info & Vehicle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(SvgImage.profile.value, height: 40),

                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Doe",
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),

                        SizedBox(height: 6),
                        Row(
                          children: [
                            SvgPicture.asset(SvgImage.start.value, height: 12),
                            SizedBox(width: 4),
                            Text(
                              "4.8",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(SvgImage.car.value, height: 16),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.boxColors,
                        // border: Border.all(color: AppColors.appTextColors),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "AC",
                        style: AppTextStyle.small12SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Joined and Book Now
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.appBgColor,
                      child: SvgPicture.asset(
                        SvgImage.profile.value,
                        height: 24,
                      ),
                    ),

                    CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.appBgColor,
                      child: SvgPicture.asset(
                        SvgImage.profile.value,
                        height: 24,
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "+2",
                        style: AppTextStyle.small12SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "4 joined",
                      style: AppTextStyle.small12SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appTextColors,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Book Now",
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),

            // Amenities and Seats Left
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(SvgImage.bag2.value, height: 16),
                    SizedBox(width: 9),
                    SvgPicture.asset(SvgImage.music.value, height: 16),
                    SizedBox(width: 9),
                    SvgPicture.asset(SvgImage.gas.value, height: 16),
                  ],
                ),
                Spacer(),
                SvgPicture.asset(SvgImage.chair.value, height: 16),
                SizedBox(width: 9),
                Text(
                  "2 seats left",
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: AppColors.appTextColors,
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
