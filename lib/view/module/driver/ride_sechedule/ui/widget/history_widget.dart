import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 169,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.appBlackColor.withOpacity(0.10),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today, 10:30 AM",
                      style: AppTextStyle.small14SizeText.copyWith(
                        color: AppColors.appDarkGrayColor73,
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),

                    Text(
                      "\$24.50",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 64,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        SvgImage.location.value,
                        colorFilter: ColorFilter.mode(
                          Color(0xFFA3A3A3),
                          BlendMode.srcIn,
                        ),
                        height: 18,
                      ),
                      SizedBox(width: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "123 Main Street, Downtown",
                            style: AppTextStyle.small14SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                          Container(
                            height: 16,
                            margin: EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.appTextGrayColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "456 Park Avenue, Uptown",
                            style: AppTextStyle.small14SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 29,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.appGrayColorE5),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(SvgImage.download.value),
                      SizedBox(width: 4),
                      Text(
                        "Invoice",
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
