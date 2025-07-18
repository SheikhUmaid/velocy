import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_total_earning_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/model/driver_total_earning_model.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/cubit/driver_profile_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/model/driver_settings_model.dart';

import '../../../../../service/local_storage/secure_storage.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.appWhiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.appGrayColorE5),
                ),
              ),
              child: BlocBuilder<DriverProfileCubit, CommonState>(
                builder: (context, state) {
                  String name = 'Guest';
                  String? profileImage;

                  if (state is CommonStateSuccess<DriverSettingsModel>) {
                    name = state.data.data?.username ?? 'Guest';
                    profileImage = state.data.data?.profileImage;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child:
                              (profileImage != null &&
                                      profileImage.startsWith("http"))
                                  ? Image.network(
                                    profileImage,
                                    height: 64,
                                    width: 64,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (_, __, ___) => SvgPicture.asset(
                                          SvgImage.profile.value,
                                          height: 64,
                                          width: 64,
                                        ),
                                  )
                                  : SvgPicture.asset(
                                    SvgImage.profile.value,
                                    height: 64,
                                    width: 64,
                                  ),
                        ),
                        const SizedBox(width: 22),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, $name",
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
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
              height: 206,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.driverSettingsPage.value),
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgImage.person.value),
                        const SizedBox(width: 11),
                        Text(
                          "Profile Settings",
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ),

                  BlocBuilder<DriverTotalEarningCubit, CommonState>(
                    builder: (context, state) {
                      final cubit = context.read<DriverTotalEarningCubit>();
                      final data =
                          (state is CommonStateSuccess)
                              ? state.data as TotalEarningResponseModel
                              : null;

                      final earnings = data?.thisMonthEarnings ?? 0.0;

                      return GestureDetector(
                        onTap: () => Get.toNamed(Routes.earningPage.value),
                        child: Row(
                          children: [
                            SvgPicture.asset(SvgImage.earnings.value),
                            const SizedBox(width: 11),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Earnings",
                                  style: AppTextStyle.small16SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                ),
                                Text(
                                  "₹${earnings.toStringAsFixed(2)} This month",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appDarkGrayColor73,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.rideHistoryPage.value),
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgImage.car.value),
                        const SizedBox(width: 11),
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

            Container(
              height: 193,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 28),
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
                      const SizedBox(width: 11),
                      Text(
                        "Settings",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.helpSupport.value),
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgImage.support.value),
                        const SizedBox(width: 11),
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
