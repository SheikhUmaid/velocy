import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class RatingPage extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Susee',
      'rating': 'Outstanding',
      'comment': 'Excellent trip, had a good driver',
      'date': 'Aug 21, 2025',
    },
    {
      'name': 'Mike',
      'rating': 'Good',
      'comment': 'Very professional and punctual',
      'date': 'Aug 19, 2025',
    },
  ];

  final Map<String, int> ratingCounts = {
    'Outstanding': 8,
    'Good': 2,
    'Okay': 0,
    'Poor': 0,
    'Disappointing': 0,
  };

  RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    int totalRatings = ratingCounts.values.reduce((a, b) => a + b);

    return Scaffold(
      appBar: CustomAppBar(title: "Joshua", centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          children: [
            Text(
              '4.9',
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 8),
            SvgPicture.asset(SvgImage.rating.value, height: 16),
            // RatingBarIndicator(
            //   rating: 4.9,
            //   itemBuilder:
            //       (context, index) => Icon(Icons.star, color: Colors.black),
            //   itemCount: 5,
            //   itemSize: 30,
            //   direction: Axis.horizontal,
            // ),
            SizedBox(height: 4),
            Text(
              'Based on $totalRatings ratings',
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: AppColors.appTextColors,
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rating Breakdown',
                style: AppTextStyle.medium18SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ),
            SizedBox(height: 12),
            ...ratingCounts.entries.map((entry) {
              double percent =
                  totalRatings > 0 ? entry.value / totalRatings : 0;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        entry.key,
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: percent,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      entry.value.toString(),
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Reviews',
                style: AppTextStyle.medium18SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ),
            SizedBox(height: 12),
            ...reviews.map(
              (review) => Card(
                color: AppColors.boxColors,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: SvgPicture.asset(SvgImage.profile.value, height: 40),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['name'],
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      Text(
                        review['date'],
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appTextColors,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(SvgImage.start.value, height: 14),
                      SizedBox(height: 6),
                      Text(
                        review['comment'],
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appTextColors,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
