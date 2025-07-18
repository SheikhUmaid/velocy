import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class PoolPaymentWidget extends StatelessWidget {
  const PoolPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Request Approved",
        centerTitle: true,
        actions: [SvgPicture.asset(SvgImage.dot.value, height: 36)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            _statusBanner(),
            const SizedBox(height: 16),
            _tripDetailsCard(),
            const SizedBox(height: 16),
            _driverCard(),
            const SizedBox(height: 16),
            _paymentSection(),
            const SizedBox(height: 16),
            _rideRulesSection(),
            const SizedBox(height: 16),
            _otherPassengersSection(),
            // const SizedBox(height: 5),
            _bottomButtons(),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget _statusBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          SvgPicture.asset(SvgImage.correct.value),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Seat Reserved - Complete Payment",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: AppColors.appWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tripDetailsCard() {
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
              SvgPicture.asset(SvgImage.calendar.value),
              SizedBox(width: 8),
              Text(
                "Sun 01 September 2025",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

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
                    ),
                  ),
                  Text(
                    "Thoraipakkam, Chennai",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: 16),
                  Text(
                    "10:00",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  Text(
                    "Krishnagiri New Busstand, Krishnagiri",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(SvgImage.locations.value, height: 16),
              SizedBox(width: 8),
              Text(
                "View in Map",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _driverCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(SvgImage.profile.value, height: 65),
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
                Row(
                  children: [
                    SvgPicture.asset(SvgImage.start.value, height: 13),

                    SizedBox(width: 4),
                    Text(
                      "4.9/5 (10 ratings)",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appTextColors,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: [
                    Chip(
                      label: Text(
                        "Verified",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    Chip(
                      label: Text(
                        "Rarely Cancels",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
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

  Widget _paymentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price (1 passenger)",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              Text(
                "₹350.00",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            onPressed: () {},
            height: 56,
            title: "Pay Now",
            radius: 8,
            color: AppColors.appBlackColor,
          ),
        ],
      ),
    );
  }

  Widget _rideRulesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ride Rules",
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          SizedBox(height: 13),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _RideRuleItem(icon: SvgImage.nosmoke.value, label: "No Smoking"),
              _RideRuleItem(icon: SvgImage.pam.value, label: "No Pets"),
              _RideRuleItem(icon: SvgImage.pool.value, label: "Max 2 Back"),
            ],
          ),
          const Divider(height: 24),
          Text(
            "Car: Maruti Baleno",
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _otherPassengersSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Other Passengers",
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          SizedBox(height: 12),
          _PassengerTile(
            name: "Aravinthan",
            route: "Thoraipakkam → Krishnagiri",
          ),
          _PassengerTile(name: "Lokesh", route: "Thoraipakkam → Krishnagiri"),
        ],
      ),
    );
  }

  Widget _bottomButtons() {
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
        const SizedBox(width: 10),
        Expanded(
          child: PrimaryOutlinedButton(
            onPressed: () {},
            title: "Report Issue",
            borderColor: AppColors.appTextColors,
            titleColor: AppColors.appBlackColor,
            radius: 8,
            height: 50,
          ),
        ),
      ],
    );
  }
}

class _RideRuleItem extends StatelessWidget {
  final String icon;
  final String label;
  const _RideRuleItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyle.small14SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            color: AppColors.appTextColors,
          ),
        ),
      ],
    );
  }
}

class _PassengerTile extends StatelessWidget {
  final String name;
  final String route;
  const _PassengerTile({required this.name, required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(SvgImage.profile.value, height: 40),
      title: Text(
        name,
        style: AppTextStyle.small16SizeText.copyWith(
          fontFamily: FontFamily.interRegular,
        ),
      ),
      subtitle: Text(
        route,
        style: AppTextStyle.small16SizeText.copyWith(
          fontFamily: FontFamily.interRegular,
          color: AppColors.appTextColors,
        ),
      ),
    );
  }
}
