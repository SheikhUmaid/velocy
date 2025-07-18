import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/cubit/rider_profile_cubit.dart';

import '../../../../helper/routes_helper.dart';
import '../../../../service/local_storage/secure_storage.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
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
          "Settings",
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 28, top: 20, bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              border: Border(top: BorderSide(color: AppColors.appGrayColorE5)),
            ),
            child: BlocBuilder<RiderProfileCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CommonError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: Colors.red,
                      ),
                    ),
                  );
                } else if (state is CommonStateSuccess) {
                  final riderProfile = state.data;
                  return Row(
                    children: [
                      SvgPicture.asset(SvgImage.profile.value, height: 50),
                      const SizedBox(width: 11),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${riderProfile.username}",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                          // Text(
                          //   "John@gmail.com",
                          //   style: AppTextStyle.small14SizeText.copyWith(
                          //     fontFamily: FontFamily.interRegular,
                          //     color: const Color.fromRGBO(115, 115, 115, 1),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(width: 15),

                      SvgPicture.asset(
                        SvgImage.arrow.value,
                        width: 16,
                        height: 16,
                      ),
                    ],
                  );
                }
                return Center(
                  child: Text(
                    "No profile data available",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),
          SettingsItem(
            iconPath: SvgImage.preferences.value,
            title: "Preferences",
            onTap: () {},
          ),
          SettingsItem(
            iconPath: SvgImage.languages.value,
            title: "Language & Region",
            trailingText: "English (US)",
            onTap: () {},
          ),
          SizedBox(height: 12),

          GestureDetector(
            onTap: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: AppColors.appBlackColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            "Logout",
                            style: TextStyle(color: AppColors.appBlackColor),
                          ),
                        ),
                      ],
                    ),
              );

              if (shouldLogout == true) {
                await SecureStorage().logout(); // ✅ clears all session data
                Get.offAllNamed(Routes.authPage.value); // Or login route
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),

              decoration: BoxDecoration(
                color: Color.fromRGBO(229, 231, 235, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(SvgImage.logout.value),
                  const SizedBox(width: 10),
                  Text(
                    "Logout",
                    style: AppTextStyle.small16SizeText.copyWith(
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
  }
}

class SettingsItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final bool showArrow;
  final String? trailingText;

  const SettingsItem({
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.showArrow = true,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // color: AppColors.appWhiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(iconPath),

                const SizedBox(width: 10),
                Text(
                  title,
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (trailingText != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      trailingText!,
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: const Color.fromRGBO(115, 115, 115, 1),
                      ),
                    ),
                  ),
                if (showArrow)
                  SvgPicture.asset(SvgImage.arrow.value, width: 16, height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
