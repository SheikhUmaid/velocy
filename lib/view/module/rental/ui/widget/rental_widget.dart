import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/profile_screen.dart';
import 'package:velocy_user_app/view/module/rental/ui/widget/rental_box_widget.dart';

class RentalWidget extends StatelessWidget {
  const RentalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ["All", "SUV", "Sedan", "Hatchback"];
    final List<Map<String, dynamic>> vehicles = [
      {
        "title": "Premium SUV",
        "subtitle": "Toyota Fortuner",
        "image": "assets/suv.jpg",
        "seats": 7,
        "bags": 4,
        "price": "\$25.00",
      },
      {
        "title": "Luxury Sedan",
        "subtitle": "Honda Civic",
        "image": "assets/sedan.jpg",
        "seats": 5,
        "bags": 2,
        "price": "\$20.00",
      },
    ];
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: false,
        title: "Select Vehicle",
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.asset(SvgImage.time2.value, height: 20),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RentalBoxWidget(
                  title: 'Sent Requests',
                  onPress: () {
                    Get.toNamed(Routes.rentRequest.value);
                  },
                ),
                RentalBoxWidget(
                  title: 'Received Requests',
                  onPress: () {
                    Get.toNamed(Routes.rentalVehicleProfile.value);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            RentalBoxWidget(
              title: 'My Garage',
              icons: SvgImage.logout.value,
              onPress: () {
                Get.toNamed(Routes.myGarage.value);
              },
            ),
            SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: categories.map((cat) => _categoryChip(cat)).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Vehicle Cards
            Expanded(
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicles[index];
                  return _vehicleCard(vehicle);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _categoryChip(String title) {
  final isSelected = title == "All";
  return Container(
    margin: const EdgeInsets.only(right: 10),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      color: isSelected ? Colors.black : Colors.white,
      borderRadius: BorderRadius.circular(9999),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(
      title,
      style: AppTextStyle.small14SizeText.copyWith(
        fontFamily: FontFamily.interRegular,
        color: isSelected ? AppColors.appBgColor : AppColors.appBlackColor,
      ),
    ),
  );
}

Widget _vehicleCard(Map<String, dynamic> vehicle) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              vehicle["title"],
              style: AppTextStyle.medium18SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey.shade300,
              ),
              child: Text(
                "Available",
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ),
          ],
        ),
        Text(
          vehicle["subtitle"],
          style: AppTextStyle.small14SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            color: AppColors.appTextColors,
          ),
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.vechileDetailsPages.value);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppImage.car2.value,
              height: 192,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(SvgImage.persons.value, height: 16),
                const SizedBox(width: 6),
                Text(
                  "${vehicle["seats"]} seats",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(SvgImage.bag.value, height: 16),
                const SizedBox(width: 4),
                Text(
                  "${vehicle["bags"]} bags",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "per hour",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: AppColors.appTextColors,
                  ),
                ),
                Text(
                  vehicle["price"],
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
  );
}
