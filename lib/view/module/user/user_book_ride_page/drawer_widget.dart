import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/service/local_storage/secure_storage.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/cubit/rider_profile_cubit.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/models/get_rider_profile_response_model.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.appWhiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 113,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.appGrayColorE5),
                    ),
                  ),
                  child: BlocBuilder<RiderProfileCubit, CommonState>(
                    builder: (context, state) {
                      if (state is CommonLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CommonError) {
                        return Center(child: Text(state.message));
                      } else if (state is CommonStateSuccess) {
                        final riderProfile =
                            state.data as GetRiderProfileResponseModel;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              riderProfile.profile ?? '',
                              height: 64,
                              width: 64,
                              errorBuilder: (context, _, __) {
                                return SvgPicture.asset(
                                  SvgImage.profile.value,
                                  height: 64,
                                  width: 64,
                                );
                              },
                            ),
                            SizedBox(width: 22),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "Hello, ${riderProfile.username}",
                                  style: AppTextStyle.medium18SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                ),
                                Text(
                                  "Welcome back",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appDarkGrayColor73,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30),
                          ],
                        );
                      }
                      return Center(child: Text("No rider profile found"));
                    },
                  ),
                ),

                Container(
                  height: 206,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.driverProfilePage.value);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(SvgImage.person.value),
                            SizedBox(width: 11),
                            Text(
                              "Profile Settings",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.riderRewardPage.value);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(SvgImage.earnings.value),
                            SizedBox(width: 11),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reward",
                                  style: AppTextStyle.small16SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                ),
                                Text(
                                  "\$1,234 this month",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appDarkGrayColor73,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.rideHistoryPage.value);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(SvgImage.car.value),
                            SizedBox(width: 11),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ride History",
                                  style: AppTextStyle.small16SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                ),
                                Text(
                                  "486 total rides",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appDarkGrayColor73,
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
              ],
            ),

            Container(
              height: 193,
              width: double.infinity,
              padding: EdgeInsets.only(left: 28),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.appGrayColorE5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(SvgImage.settings.value),
                      SizedBox(width: 11),
                      Text(
                        "Settings",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.helpSupport.value);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgImage.support.value),
                        SizedBox(width: 11),
                        Text(
                          "Help & Support",
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                "Are you sure you want to logout?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, false),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Logout"),
                                ),
                              ],
                            ),
                      );

                      if (shouldLogout == true) {
                        await SecureStorage().logout();
                        Get.offAllNamed(Routes.authPage.value);
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgImage.logout.value),
                        const SizedBox(width: 11),
                        Text(
                          "Logout",
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
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
