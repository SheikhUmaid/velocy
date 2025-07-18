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
import 'package:velocy_user_app/view/module/rental/vehicle_details/ui/widget/vechile_box_card_widget.dart';

class VechileDetailsWidget extends StatelessWidget {
  const VechileDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String rentalDuration = '4 Hours';
    final List<String> durations = ['1 Hour', '4 Hours', '8 Hours', '1 Day'];
    return Scaffold(
      appBar: CustomAppBar(
        title: "Vehicle Details",
        centerTitle: true,
        appElevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.rentalOwnerDetails.value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset(SvgImage.profile.value),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,

              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.car2.value),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Toyota Innova Crysta",
                        style: AppTextStyle.medium20SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.boxColors,

                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          "SUV",
                          style: AppTextStyle.small14SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(SvgImage.rating.value, height: 16),
                      SizedBox(width: 8),
                      Text(
                        "(4.2)",
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "₹1,200 ",
                    style: AppTextStyle.medium24SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  Text(
                    "/hour",
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VehicleFeatureCard(
                        title: 'Capacity',
                        subTitle: '7 Seater',
                        icons: SvgImage.capacity.value,
                      ),
                      VehicleFeatureCard(
                        title: 'AC',
                        subTitle: 'Yes',
                        icons: SvgImage.ac.value,
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VehicleFeatureCard(
                        title: 'Fuel',
                        subTitle: 'Diesel',
                        icons: SvgImage.fuel.value,
                      ),
                      VehicleFeatureCard(
                        title: 'Transmission',
                        subTitle: 'Automatic',
                        icons: SvgImage.settings.value,
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rental Duration",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.boxColors),
                        ),
                        child: DropdownButton<String>(
                          value: rentalDuration,
                          onChanged: (String? newValue) {
                            // setState(() {
                            //   rentalDuration = newValue!;
                            // });
                          },
                          items:
                              durations.map<DropdownMenuItem<String>>((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: AppTextStyle.small16SizeText
                                        .copyWith(
                                          fontFamily: FontFamily.interRegular,
                                        ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Pickup Time",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "mm/dd/yyyy --:-- --",
                          style: AppTextStyle.medium18SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                        const Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Drop Time",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "mm/dd/yyyy --:-- --",
                          style: AppTextStyle.medium18SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                        const Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Divider(height: 32),
                  Center(
                    child: Text(
                      'Free cancellation up to 24 hours before pickup',
                      style: AppTextStyle.small12SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appTextColors,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          color: AppColors.boxColors,
                          height: 48,
                          onPressed: () {},
                          title: "Schedule Later",
                          textColor: AppColors.appBlackColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PrimaryButton(
                          height: 48,
                          onPressed: () {},
                          title: "Rent Now",
                          color: AppColors.appBlackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
