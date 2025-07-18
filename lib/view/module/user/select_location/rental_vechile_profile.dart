import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/rental_vechile_profile/component/rider_card.dart';

class RentalVechileProfile extends StatelessWidget {
  final List<Map<String, String>> riders = [
    {'name': 'Aliyan', 'number': 'KA 01 AB 1234'},
    {'name': 'Ajay', 'number': 'KA 01 AB 1234'},
    {'name': 'Vijay', 'number': 'KA 01 AB 1234'},
    {'name': 'Raju', 'number': 'KA 01 AB 1234'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhiteColor,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.appBlackColor,
            size: 24,
          ),
        ),
        title: Text(
          "Rental riders",
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: riders.length,
        itemBuilder: (context, index) {
          return RiderCard(
            name: riders[index]['name']!,
            vehicleNumber: riders[index]['number']!,
            carModel: 'Toyota Camry - Silver',
          );
        },
      ),
    );
  }
}
