import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/ui/page/live_driver_cab_tracking.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/ui/page/testing_live_driver_cab_page.dart';
import 'package:velocy_user_app/view/module/driver/recent_rides_page/cubit/driver_accept_ride_cubit.dart';
import 'package:velocy_user_app/view/module/driver/recent_rides_page/cubit/driver_decline_ride_cubit.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

import '../../../../utils/custom_toast.dart';
import 'cubit/ride_details_cubit.dart';
import 'model/ride_details_model.dart';

class RideDetailsScreen extends StatefulWidget {
  const RideDetailsScreen({super.key});

  @override
  State<RideDetailsScreen> createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  int? id;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final rideId = Get.arguments;
      id = rideId;
      if (rideId != null) {
        await context.read<RideDetailsCubit>().fetchRideDetails(rideId);
      }
    });
  }

  void accept() async {
    final cubit = context.read<DriverAcceptRideCubit>();
    await cubit.driverAcceptRide(id!);
    CustomToast.success(message: "Accept Ride Successfully!");
    // Get.toNamed(Routes.driverCabTracking.value, arguments: id);
    final rideDetailsState = context.read<RideDetailsCubit>().state;
    if (rideDetailsState is CommonStateSuccess<RideDetailsModel>) {
      final model = rideDetailsState.data;
    } else {
      CustomToast.error(message: "Ride details not loaded.");
    }
  }

  void decline() async {
    final cubit = context.read<DriverDeclineRideCubit>();
    await cubit.driverDeclineRide(id!);
    CustomToast.success(message: "Decline Ride Successfully!");
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appWhiteColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appBgColor,
          body: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildRideDetailCard(),

                      Container(
                        height: 56,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.appWhiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.appBlackColor.withOpacity(0.05),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.infinity,
                            color: Color(0xFFF5F5F5),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rider fare",
                                  style: AppTextStyle.small16SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                ),

                                Text(
                                  "\$10.00",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: 278,
                        width: double.infinity,
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(AppImage.map2.value),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 81,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFE5E5E5),
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    height: 52,
                    borderRadius: 8,
                    onPressed: () {
                      decline();
                    },
                    text: "Decline",
                    color: AppColors.appGrayColorE5,
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    height: 52,
                    borderRadius: 8,
                    onPressed: () {
                      accept();
                    },
                    text: "Accept",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appWhiteColor,
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyle.small14SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            color: AppColors.appGrayColor52,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 57,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.appWhiteColor,
        border: Border(
          bottom: BorderSide(color: AppColors.appBlackColor.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ride Details",
            style: AppTextStyle.medium18SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          SvgPicture.asset(SvgImage.dot.value),
        ],
      ),
    );
  }

  Widget _buildRideDetailCard() {
    return BlocBuilder<RideDetailsCubit, CommonState>(
      builder: (context, state) {
        print("RideDetailsCubit state: $state");
        if (state is CommonLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        } else if (state is CommonStateSuccess<RideDetailsModel>) {
          final model = state.data;

          print(" MODEEL--${state.data.city}");

          return Container(
            height: 308,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.appBlackColor.withOpacity(0.05),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(SvgImage.profile.value, height: 48),
                    const SizedBox(width: 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${model.user}",
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "4.8",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: const Color(0xff525252),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset(SvgImage.start.value, height: 13),
                            Text(
                              "• 123 rides",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: const Color(0xff525252),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                SizedBox(
                  height: 88,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImage.round.value,
                            color: AppColors.appGrayColor52,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            model.fromLocation.toString(),
                            style: AppTextStyle.small14SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          width: 2,
                          height: 24,
                          child: Divider(thickness: 24),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImage.location.value,
                            color: AppColors.appGrayColor52,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            model.toLocation.toString(),
                            style: AppTextStyle.small14SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem("Distance", "${model.distanceKm} km"),
                    _buildStatItem(
                      "Estimated fare",
                      "₹${model.estimatedPrice}",
                    ),
                    _buildStatItem("Offered fare", "₹${model.offeredPrice}"),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
