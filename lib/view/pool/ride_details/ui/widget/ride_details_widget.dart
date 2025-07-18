import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class RideDetailsWidget extends StatelessWidget {
  const RideDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Ride Details"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _routeCard(),
          const SizedBox(height: 12),
          _priceCard(),
          const SizedBox(height: 12),
          _driverCard(),
          const SizedBox(height: 12),
          _infoCard(),
          const SizedBox(height: 15),
          _carCard(),
          const SizedBox(height: 12),
          _passengerCard(),
          const SizedBox(height: 12),
          _buttonRow(),
          const SizedBox(height: 20),
          _requestButton(),
        ],
      ),
    );
  }

  Widget _routeCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Sun 01 September",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              Spacer(),
              SvgPicture.asset(SvgImage.map2.value, height: 16),
              SizedBox(width: 8),
              Text(
                "View in Map",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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

  Widget _priceCard() {
    return _card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Price for 1 passenger ",
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              color: AppColors.appTextColors,
            ),
          ),
          Text(
            "₹350.00",
            style: AppTextStyle.medium20SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _driverCard() {
    return _card(
      child: Row(
        children: [
          SvgPicture.asset(SvgImage.profile.value, height: 64),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Joshua",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "⭐ 4.9/5 • 10 ratings",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                const SizedBox(height: 17),
                Row(
                  children: [
                    Expanded(child: _tag("✅ Verified Profile")),
                    const SizedBox(width: 6),
                    Expanded(child: _tag("🕓 Rarely cancels")),
                  ],
                ),
              ],
            ),
          ),
          SvgPicture.asset(SvgImage.whatsapp.value, height: 24),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return Text(
      "Your booking won't be confirmed until the driver approves your request.",
      style: AppTextStyle.small16SizeText.copyWith(
        fontFamily: FontFamily.interRegular,
        color: AppColors.appTextColors,
      ),
    );
  }

  Widget _carCard() {
    return Row(
      children: [
        Icon(Icons.block),
        SizedBox(width: 4),
        Text(
          "No Pets",
          style: AppTextStyle.small14SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
        SizedBox(width: 16),
        SvgPicture.asset(SvgImage.persons.value),
        SizedBox(width: 4),
        Text(
          "Max 2 in the back",
          style: AppTextStyle.small14SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
        // SizedBox(width: 16),
        // Text("MARUTI BALENO", style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _passengerCard() {
    return _card(
      child: Text(
        "Other Passengers",
        style: AppTextStyle.small16SizeText.copyWith(
          fontFamily: FontFamily.interRegular,
        ),
      ),
    );
  }

  Widget _buttonRow() {
    return Row(
      children: [
        Expanded(
          child: PrimaryOutlinedButton(
            onPressed: () {},
            title: "Share Ride",
            borderColor: AppColors.appTextColors,
            titleColor: AppColors.appBlackColor,
            radius: 8,
            height: 50,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: PrimaryOutlinedButton(
            onPressed: () {},
            title: "Report Ride",
            borderColor: AppColors.appTextColors,
            titleColor: AppColors.appBlackColor,
            radius: 8,
            height: 50,
          ),
        ),
      ],
    );
  }

  Widget _requestButton() {
    return PrimaryButton(
      onPressed: () {
        Get.toNamed(Routes.poolPayment.value);
      },
      title: "Request to Book",
      radius: 8,
      height: 56,
      color: AppColors.appBlackColor,
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Expanded(
        child: Text(
          text,
          style: AppTextStyle.small12SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
