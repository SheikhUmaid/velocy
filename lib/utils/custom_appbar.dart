import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final List<Widget>? actions;
  final double appElevation;

  const CustomAppBar({
    Key? key,
    this.title = "",
    this.showBackButton = true,
    this.onBackTap,
    this.centerTitle = false,
    this.actions,
    this.appElevation = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appWhiteColor,
      elevation: appElevation,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading:
          showBackButton
              ? IconButton(
                onPressed: onBackTap ?? () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.appBlackColor,
                  size: 24,
                ),
              )
              : null,
      title: Text(
        title,
        style: AppTextStyle.medium18SizeText.copyWith(
          fontFamily: FontFamily.interRegular,
          color: AppColors.appBlackColor,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
