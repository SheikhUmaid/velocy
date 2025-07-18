import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class RiderRewardPage extends StatelessWidget {
  const RiderRewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: SvgPicture.asset(SvgImage.reward.value, width: 24, height: 24),
        ),

        backgroundColor: AppColors.appWhiteColor,
        elevation: 1,
        title: Text(
          'Rewards',
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: SvgPicture.asset(SvgImage.notification.value),
            // child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.appGrayColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '2,450',
                    style: AppTextStyle.extraLarge30SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Points Balance',
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: const Color.fromRGBO(115, 115, 115, 1),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Redeem Points',
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appColorF5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 23),

            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        SvgImage.redeem.value,
                        width: 21,
                        height: 21,
                      ),

                      const SizedBox(height: 6),
                      Text(
                        'Redeem Offers',
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appDarkGrayColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        SvgImage.share.value,
                        width: 21,
                        height: 21,
                      ),

                      const SizedBox(height: 5),
                      Text(
                        'Share & Earn',
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appDarkGrayColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            Text(
              'Refer Friends',
              style: AppTextStyle.medium18SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF2F2F2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FRIEND25',
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appDarkGrayColor,
                    ),
                  ),
                  SvgPicture.asset(SvgImage.copy.value, width: 16, height: 16),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'Top Earners',
              style: AppTextStyle.medium18SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            const SizedBox(height: 12),
            _buildEarnerItem(
              'assets/app_images/app_icon/profile.svg',
              'Alex M.',
              '4,520',
              '#1',
            ),
            _buildEarnerItem(
              'assets/app_images/app_icon/profile.svg',
              'Sarah K.',
              '3,890',
              '#2',
            ),
            _buildEarnerItem(
              'assets/app_images/app_icon/profile.svg',
              'John D.',
              '3,450',
              '#3',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarnerItem(
    String imagePath,
    String name,
    String points,
    String rank,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset(imagePath, width: 40),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              Text(
                '$points points',
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: const Color.fromRGBO(115, 115, 115, 1),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            rank,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ],
      ),
    );
  }
}
