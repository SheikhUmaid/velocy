import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/cubits/ride_history_cubit.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/cubits/ride_history_schedule_cubit.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/models/get_driver_ride_history_model.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/models/get_schedule_rides_model.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class ScheduledWidget extends StatelessWidget {
  const ScheduledWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledRideCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CommonError) {
          return Center(child: Text(state.message ?? "Something went wrong"));
        } else if (state is CommonStateSuccess) {
          if (state.data != null) {
            final response = state.data as UpcomigScheduledModel;
            final scheduledRides = response.data ?? [];
            return Expanded(
              child: ListView.builder(
                itemCount: scheduledRides.length,
                itemBuilder: (context, index) {
                  final ride = scheduledRides[index];

                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.rideDetailsPage.value);
                    },
                    child: Container(
                      height: 139,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.appWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appBlackColor.withOpacity(0.10),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Date & Amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${ride.scheduledDate ?? "Unknown Date"}, ${ride.scheduledTime ?? "--:--"}",
                                style: AppTextStyle.small14SizeText.copyWith(
                                  color: AppColors.appDarkGrayColor73,
                                  fontFamily: FontFamily.interRegular,
                                ),
                              ),
                              // Text(
                              //   "₹${ride.amount ?? '--'}",
                              //   style: AppTextStyle.small14SizeText.copyWith(
                              //     fontFamily: FontFamily.interRegular,
                              //   ),
                              // ),
                            ],
                          ),

                          // Location & Cancel Button
                          Stack(
                            children: [
                              Container(
                                height: 64,
                                margin: const EdgeInsets.only(top: 13),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      SvgImage.location.value,
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFFA3A3A3),
                                        BlendMode.srcIn,
                                      ),
                                      height: 18,
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ride.fromLocation ?? "From Location",
                                          style: AppTextStyle.small14SizeText
                                              .copyWith(
                                                fontFamily:
                                                    FontFamily.interRegular,
                                              ),
                                        ),
                                        Container(
                                          height: 16,
                                          margin: const EdgeInsets.only(
                                            left: 4,
                                          ),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color:
                                                    AppColors.appTextGrayColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ride.toLocation ?? "To Location",
                                          style: AppTextStyle.small14SizeText
                                              .copyWith(
                                                fontFamily:
                                                    FontFamily.interRegular,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: PrimaryButton(
                                  height: 30,
                                  width: 80,
                                  onPressed: () {
                                    // TODO: Cancel ride logic
                                  },
                                  text: "Cancel",
                                  style: AppTextStyle.small16SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appWhiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
        return Expanded(
          child: Center(
            child: Text(
              "No ride history available.",
              style: AppTextStyle.small14SizeText.copyWith(
                color: AppColors.appDarkGrayColor73,
                fontFamily: FontFamily.interRegular,
              ),
            ),
          ),
        );
      },
    );
  }
}
