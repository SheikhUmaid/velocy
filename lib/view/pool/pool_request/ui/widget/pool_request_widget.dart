import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/rental/rental_owner_profile/ui/widget/profile_widget.dart';

class PoolRequestWidget extends StatelessWidget {
  const PoolRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(title: "Pool Requests", centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _requestCard(),
            const SizedBox(height: 50),
            PrimaryButton(
              onPressed: () {},
              title: "Beginn trip",
              height: 56,
              color: AppColors.appBlackColor,
              radius: 8,
            ),
            const SizedBox(height: 10),

            PrimaryButton(
              onPressed: () {},
              title: "Cancel Request",
              height: 56,
              color: AppColors.appTextColors,
              textColor: AppColors.appBlackColor,
              radius: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _requestCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Request #2025-0123",
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  "Waiting Approval",
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProfileWidget(),

          // Row(
          //   children: [
          //     SvgPicture.asset(SvgImage.profile.value, height: 67, width: 65),
          //     const SizedBox(width: 8),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'John',
          //             style: AppTextStyle.small14SizeText.copyWith(
          //               fontFamily: FontFamily.interRegular,
          //             ),
          //           ),
          //           SizedBox(height: 3),

          //           Text(
          //             'KA 01 AB 1234',
          //             style: AppTextStyle.small14SizeText.copyWith(
          //               fontFamily: FontFamily.interRegular,
          //               color: AppColors.appTextColors,
          //             ),
          //           ),
          //           SizedBox(height: 3),
          //           Text(
          //             'Toyota Camry – Silver',
          //             style: AppTextStyle.small14SizeText.copyWith(
          //               fontFamily: FontFamily.interRegular,
          //               color: AppColors.appTextColors,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 20),
          Text(
            "Vehicle Details",
            style: AppTextStyle.medium18SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          const SizedBox(height: 17),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vehicle Number",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              Text(
                "ABC 1234",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Model",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              Text(
                "Toyota Camry",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                "Sun 01 September",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              Spacer(),
              SvgPicture.asset(SvgImage.map2.value),
              SizedBox(width: 10),

              Text(
                "Toyota Camry",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Column(
                children: [
                  SvgPicture.asset(SvgImage.round.value, height: 16),
                  Container(height: 60, width: 1, color: Colors.grey),
                  SvgPicture.asset(SvgImage.locations.value, height: 16),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "04:00",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  Text(
                    "Thoraipakkam, Chennai",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: 16),
                  Text(
                    "10:00",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  Text(
                    "Krishnagiri New Busstand, Krishnagiri",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          Text(
            "Duration: 5h",
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              color: AppColors.appTextColors,
            ),
          ),
        ],
      ),
    );
  }
}
