import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_rides_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_total_earning_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/model/driver_rides_model.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/component/earning_summary_card_widget.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class EarningScreen extends StatefulWidget {
  EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  final RxInt selectButton = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    await context.read<DriverTotalEarningCubit>().fetchTotalEarning();
    await context.read<DriverRidesCubit>().fetchRides();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: AppColors.appBgColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.appBgColor,
            appBar: AppBar(
              backgroundColor: AppColors.appBgColor,
              elevation: 1,
              centerTitle: false,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.appBlackColor,
                  size: 24,
                ),
              ),
              title: Text(
                "Earnings & Reports",
                style: AppTextStyle.medium18SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              actions: [
                SvgPicture.asset(SvgImage.notification.value),
                SizedBox(width: 16),
              ],
            ),

            body: SingleChildScrollView(
              child: Column(
                children: [
                  EarningSummaryCard(),

                  Container(
                    height: 48,
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              selectButton.value = 0;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    selectButton.value == 0
                                        ? Color(0xFFFFFFFF)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Daily",
                                style: AppTextStyle.small16SizeText.copyWith(
                                  fontFamily: FontFamily.interRegular,
                                  color:
                                      selectButton.value == 0
                                          ? AppColors.appBlackColor
                                          : AppColors.appGrayColor52,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              selectButton.value = 1;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    selectButton.value == 1
                                        ? Color(0xFFFFFFFF)
                                        : Colors.transparent,

                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Weekly",
                                style: AppTextStyle.small16SizeText.copyWith(
                                  fontFamily: FontFamily.interRegular,
                                  color:
                                      selectButton.value == 1
                                          ? AppColors.appBlackColor
                                          : AppColors.appGrayColor52,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              selectButton.value = 2;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    selectButton.value == 2
                                        ? Color(0xFFFFFFFF)
                                        : Colors.transparent,

                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Monthly",
                                style: AppTextStyle.small16SizeText.copyWith(
                                  fontFamily: FontFamily.interRegular,
                                  color:
                                      selectButton.value == 2
                                          ? AppColors.appBlackColor
                                          : AppColors.appGrayColor52,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 156,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    color: AppColors.appWhiteColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Incentive Tracker",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),

                            Text(
                              "4 days left",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: AppColors.appGrayColor52,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          height: 88,
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.appColorF5,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: AppTextStyle.small14SizeText
                                        .copyWith(
                                          fontFamily: FontFamily.interRegular,
                                        ),
                                  ),

                                  Text(
                                    "18/25 rides",
                                    style: AppTextStyle.small14SizeText
                                        .copyWith(
                                          fontFamily: FontFamily.interRegular,
                                        ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(SvgImage.slider.value),
                              Text(
                                "Complete 7 more rides to earn \$150 bonus",
                                style: AppTextStyle.small14SizeText.copyWith(
                                  fontFamily: FontFamily.interRegular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 92,
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    color: AppColors.appWhiteColor,
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Available for instant payout",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),

                            Text(
                              "\$245.00",
                              style: AppTextStyle.medium24SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: AppColors.appGrayColor52,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: PrimaryButton(
                            onPressed: () {},
                            height: 40,
                            width: 102.02,
                            text: "Cash Out",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                              color: AppColors.appWhiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildRideRequestsHeader(),
                  _buildRideRequestsList(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildRideRequestsHeader() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      color: AppColors.appWhiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ride Requests",
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildRideRequestsList() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const BouncingScrollPhysics(),
  //     itemCount: 8, // Replace with actual item count

  //     itemBuilder: (context, index) {
  //       return GestureDetector(
  //         onTap: () {
  //           // Get.toNamed(Routes.rideDetailsPage.value);
  //         },
  //         child: Container(
  //           color: AppColors.appWhiteColor,
  //           child: Container(
  //             height: 57,
  //             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //             padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
  //             decoration: BoxDecoration(
  //               color: AppColors.appWhiteColor,
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border(bottom: BorderSide(color: AppColors.appColorF5)),
  //             ),
  //             child: Stack(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Container(
  //                       height: 40,
  //                       width: 40,
  //                       padding: EdgeInsets.all(12),
  //                       margin: EdgeInsets.only(right: 16),
  //                       decoration: BoxDecoration(
  //                         color: AppColors.appColorF5,
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: SvgPicture.asset(SvgImage.car.value),
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Downtown - Airport",
  //                           style: AppTextStyle.small16SizeText.copyWith(
  //                             fontFamily: FontFamily.interRegular,
  //                           ),
  //                         ),
  //                         Text(
  //                           "Today, 2:30 PM",
  //                           style: AppTextStyle.small14SizeText.copyWith(
  //                             fontFamily: FontFamily.interRegular,
  //                             color: AppColors.appGrayColor52,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 Align(
  //                   alignment: Alignment.centerRight,
  //                   child: Text(
  //                     "\$24.50",
  //                     style: AppTextStyle.small16SizeText.copyWith(
  //                       fontFamily: FontFamily.interRegular,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildRideRequestsList() {
    return BlocBuilder<DriverRidesCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        } else if (state is CommonDataFetchSuccess<DriverRideModel>) {
          final rides = state.data;

          if (rides.isEmpty) {
            return const Center(child: Text("No rides available"));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.rideDetailsPage.value, arguments: ride.id);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ride.toLocation),
                          Text("₹${ride.price.toStringAsFixed(2)}"),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${ride.toLatitude}, ${ride.toLongitude}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is CommonError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
