import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/cubit/driver_cancel_ride_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/cubit/driver_genrate_otp_cubit.dart';
import 'package:velocy_user_app/view/module/driver/recent_rides_page/cubit/ride_details_cubit.dart';
import 'package:velocy_user_app/view/module/driver/recent_rides_page/model/ride_details_model.dart';
import 'package:velocy_user_app/view/notification/component/notification_button.dart';

import '../../../../../../utils/custom_toast.dart';
import '../../cubit/driver_begein_ride_cubit.dart';

class DriverCabTrackingWidget extends StatefulWidget {
  const DriverCabTrackingWidget({super.key});

  @override
  State<DriverCabTrackingWidget> createState() =>
      _DriverCabTrackingWidgetState();
}

class _DriverCabTrackingWidgetState extends State<DriverCabTrackingWidget> {
  int? id;
  @override
  void initState() {
    super.initState();
    final rideId = Get.arguments;
    id = rideId;
  }

  void cancel() async {
    final cubit = context.read<DriverCancelRideCubit>();
    await cubit.driverCancelRide(id!);
    CustomToast.success(message: "Ride Cancelled Successfully!");
  }

  void begin() async {
    final cubit = context.read<DriverBeginRideCubit>();
    await cubit.driverBeginRide(id!);
    Get.toNamed(Routes.dropLocation.value, arguments: id);
    CustomToast.success(message: "Ride Begin Successfully!");
  }

  void notifiyArrival() async {
    final cubit = context.read<DriverGenrateOtpCubit>();
    await cubit.driverGenrateOtp(id!);
    print("OTP Sent to Socket");
    CustomToast.success(message: "Notify Arrival Sent");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Driver Cab Tracking", centerTitle: true),
      body: SingleChildScrollView(
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

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(SvgImage.round.value, height: 12),
                          Dash(
                            direction: Axis.vertical,
                            length: 70,
                            dashLength: 5,
                            dashColor: AppColors.appBlackColor,
                          ),
                          SvgPicture.asset(SvgImage.location.value, height: 12),
                        ],
                      ),
                      const SizedBox(width: 14),

                      /// Right side: TextFields
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 8),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pick-up",
                                      style: AppTextStyle.small14SizeText
                                          .copyWith(
                                            fontFamily: FontFamily.interRegular,
                                          ),
                                    ),
                                    Text(
                                      "123 Main Street, Downtown",
                                      style: AppTextStyle.small14SizeText
                                          .copyWith(
                                            fontFamily: FontFamily.interRegular,
                                          ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(Icons.check_circle, color: Colors.black),
                              ],
                            ),

                            const SizedBox(height: 40),
                            Text(
                              "Drop-off",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                            Text(
                              "123 Main Street, Downtown",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
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

            const Divider(height: 24),

            // 👤 User info and actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  SvgPicture.asset(SvgImage.profile.value, height: 50),

                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "User Name",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(229, 231, 235, 1),
                    ),
                    child: SvgPicture.asset(SvgImage.call.value),
                  ),
                  // SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(229, 231, 235, 1),
                    ),
                    child: SvgPicture.asset(SvgImage.sendMessage.value),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 19),

            // 🚘 Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  BlocListener<DriverGenrateOtpCubit, CommonState>(
                    listener: (context, state) {
                      if (state is CommonError) {
                        CustomToast.error(message: state.message);
                      } else if (state is CommonStateSuccess) {
                        CustomToast.success(
                          message: "OTP generated successfully",
                        );
                      }
                    },
                    child: _buildNotifiyButton(),
                  ),

                  const SizedBox(height: 15),

                  GestureDetector(
                    onTap: () {
                      cancel();
                    },
                    child: NotificationActionButton(
                      title: 'Cancel Ride',
                      icons: SvgImage.rideCancel.value,
                      backgroungColors: AppColors.appBorderGrayColor,
                      colors: AppColors.appBlackColor,
                    ),
                  ),
                  const SizedBox(height: 15),

                  GestureDetector(
                    onTap: () {
                      begin();
                    },
                    child: NotificationActionButton(
                      title: 'Begin',
                      icons: SvgImage.send.value,
                      backgroungColors: Colors.black,
                      colors: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifiyButton() {
    return BlocBuilder<DriverGenrateOtpCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }

        return GestureDetector(
          onTap: () {
            notifiyArrival();
          },
          child: NotificationActionButton(
            title: 'Notify Arrival',
            icons: SvgImage.notification.value,
            backgroungColors: Colors.black,
            colors: Colors.white,
          ),
        );
      },
    );
  }
}
