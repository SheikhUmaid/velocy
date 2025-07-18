import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class RideCompleteScreen extends StatelessWidget {
  const RideCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedPayment = "Cash";
    return Scaffold(
      appBar: CustomAppBar(
        title: "Ride Complete",
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.reportScreen.value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(SvgImage.unsafe.value),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ride Info
            Row(
              children: [
                SvgPicture.asset(SvgImage.profile.value, height: 48),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John's Ride",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                    Text(
                      "Toyota Camry • ABC 123",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appTextColors,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                SvgPicture.asset(SvgImage.time.value),
                // Icon(Icons.access_time, size: 18),
                SizedBox(width: 8),
                Text(
                  "Today, 2:30 PM • 25 min",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: AppColors.appTextColors,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SvgPicture.asset(SvgImage.round.value, height: 12),
                SizedBox(width: 8),
                Text(
                  "123 Start Street",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset(SvgImage.locations.value, height: 12),
                SizedBox(width: 4),
                Text(
                  "456 End Avenue",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            SizedBox(height: 20),
            // Fare Breakdown
            Text(
              "Fare Breakdown",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            const SizedBox(height: 8),
            _fareRow("Base fare", "\$12.50"),
            _fareRow("Distance (5.2 mi)", "\$8.30"),
            _fareRow("Time (25 min)", "\$6.20"),
            const Divider(),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.rideComplete.value);
              },
              child: _fareRow("Total", "\$27.00", isBold: true),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                SvgPicture.asset(SvgImage.ticket.value, height: 19),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter promo code",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  height: 50,
                  width: 90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text("Apply"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Tip Section
            Text(
              "Tip your driver",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tipOption("\$2"),
                _tipOption("\$4"),
                _tipOption("\$6"),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter custom amount",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),

            // Payment method and Pay Button
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.boxColors,
                      // border: Border.all(color: AppColors.appTextColors),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedPayment,
                        icon: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                        items:
                            ['Cash', 'Wallet', 'UPI'].map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Icon(
                                      value == "Cash"
                                          ? Icons.money
                                          : value == "Wallet"
                                          ? Icons.account_balance_wallet
                                          : Icons.qr_code,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      children: [
                                        Text(
                                          "pay using",
                                          style: AppTextStyle.small12SizeText
                                              .copyWith(
                                                fontFamily:
                                                    FontFamily.poppinsRegular,
                                              ),
                                        ),
                                        Text(
                                          value,
                                          style: AppTextStyle.medium18SizeText
                                              .copyWith(
                                                fontFamily:
                                                    FontFamily.poppinsRegular,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.appBlackColor,

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "₹380",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.poppinsRegular,
                              fontWeight: FontWeight.w400,
                              color: AppColors.appWhiteColor,
                            ),
                          ),
                          Text(
                            "Total",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.poppinsRegular,
                              color: AppColors.appTextColors,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Text(
                        "Pay",
                        style: AppTextStyle.medium22SizeText.copyWith(
                          fontFamily: FontFamily.poppinsRegular,
                          color: AppColors.appWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fareRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipOption(String amount) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.appTextColors),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          amount,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ),
    );
  }
}
