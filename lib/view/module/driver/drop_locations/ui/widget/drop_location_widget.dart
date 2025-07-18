import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/drop_locations/ui/widget/dotted_line_colum.dart';

import '../../../../../../utils/custom_toast.dart';
import '../../../driver_cab_tracking/cubit/driver_complete-ride_cubit.dart';

class DropLocationWidget extends StatefulWidget {
  const DropLocationWidget({super.key});

  @override
  State<DropLocationWidget> createState() => _DropLocationWidgetState();
}

class _DropLocationWidgetState extends State<DropLocationWidget> {
  int? id;
  @override
  void initState() {
    super.initState();
    final rideId = Get.arguments;
    id = rideId;
  }

  void complete() async {
    final cubit = context.read<DriverCompleteRideCubit>();
    await cubit.driverCompleteRide(id!);
    CustomToast.success(message: "Ride Complete Successfully!");
    Get.toNamed(Routes.driverRideComplete.value, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Drop location",
        actions: [SvgPicture.asset(SvgImage.notification.value)],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.map2.value),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    top: 80,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("2.5 miles away"),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("ETA: 15 mins\n3.2 km remaining"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
              decoration: BoxDecoration(
                color: Color.fromRGBO(229, 231, 235, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Ride",
                    style: AppTextStyle.extraLarge30SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$20.50",
                        style: AppTextStyle.extraLarge34SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "10km",
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appTextColors,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            PickupDropDesign(),
            Spacer(),

            PrimaryButton(
              radius: 8,
              height: 56,
              onPressed: () {
                complete();
              },
              title: "Ride Completed",
              color: AppColors.appBlackColor,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
