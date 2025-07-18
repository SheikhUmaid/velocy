import 'package:flutter/material.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';

import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/rental/rental_owner_profile/ui/widget/profile_widget.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class RentalOwnerWidget extends StatelessWidget {
  const RentalOwnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Rental Vehicle Owner Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileWidget(),

            const SizedBox(height: 20),

            /// Price
            Text(
              'Price',
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: AppColors.appTextColors,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '\$120',
              style: AppTextStyle.medium24SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: Color.fromRGBO(82, 82, 82, 1),
              ),
            ),

            const SizedBox(height: 20),

            /// Vehicle Photos
            Text(
              'Vehicle Photos',
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: AppColors.appBlackColor,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder:
                    (_, index) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          AppImage.numberPlate.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              ),
            ),

            const SizedBox(height: 20),

            /// Aadhar Card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Owner Addhar Card',
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.boxColors),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'View adhar',
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AppImage.adharCard.value,
                height: 192,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            /// Vehicle Papers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Owner Addhar Card',
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.boxColors),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'View papers',
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AppImage.vechilePaper.value,
                height: 192,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      /// Bottom Buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Free cancellation up to 24 hours before pickup',
              style: AppTextStyle.small12SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: AppColors.appTextColors,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    height: 48,
                    borderRadius: 8,
                    color: AppColors.boxColors,
                    onPressed: () {},
                    text: "Schedule Later",
                    style: TextStyle(
                      color: AppColors.appBlackColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    height: 48,
                    onPressed: () {},
                    text: "Schedule Later",
                    borderRadius: 8,
                    color: AppColors.appBlackColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
