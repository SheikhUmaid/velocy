import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/cubits/ride_history_cubit.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/models/get_driver_ride_history_model.dart';

class CancelledWidget extends StatelessWidget {
  CancelledWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideHistoryCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CommonError) {
          return Center(child: Text(state.message ?? "Something went wrong"));
        } else if (state is CommonStateSuccess) {
          if (state.data != null) {
            final response = state.data as DriverRideHistoryModel;
            final rideHistories = response.cancelledRides ?? [];
            return Expanded(
              child: ListView.builder(
                itemCount: rideHistories.length,
                itemBuilder: (context, index) {
                  final rideHistory = rideHistories[index];
                  return Container(
                    height: 169,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.appWhiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.appBlackColor.withOpacity(0.10),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${rideHistory.date}, ${rideHistory.startTime ?? '00:00'}",
                              style: AppTextStyle.small14SizeText.copyWith(
                                color: AppColors.appDarkGrayColor73,
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),

                            Text(
                              "\$${rideHistory.amountReceived}",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 64,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgImage.location.value,
                                colorFilter: ColorFilter.mode(
                                  Color(0xFFA3A3A3),
                                  BlendMode.srcIn,
                                ),
                                height: 18,
                              ),
                              SizedBox(width: 16),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${rideHistory.fromLocation ?? 'Unknown Location'}",
                                    style: AppTextStyle.small14SizeText
                                        .copyWith(
                                          fontFamily: FontFamily.interRegular,
                                        ),
                                  ),
                                  Container(
                                    height: 16,
                                    margin: EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: AppColors.appTextGrayColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${rideHistory.toLocation ?? 'Unknown Location'}",
                                    style: AppTextStyle.small14SizeText
                                        .copyWith(
                                          fontFamily: FontFamily.interRegular,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.rideSchedulePage.value);
                          },
                          child: Container(
                            height: 29,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.appGrayColorE5,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(SvgImage.download.value),
                                SizedBox(width: 4),
                                Text(
                                  "Invoice",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
