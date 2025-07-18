import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/rental/ui/page/rental_dashboard_page.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/drawer_widget.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/user_book_ride_screen.dart';
import 'package:velocy_user_app/view/module/user/user_coprate_page/user_coprate_screen.dart';
import 'package:velocy_user_app/view/module/user/user_pool_page/user_pool_screen.dart';
import 'package:velocy_user_app/view/module/user/user_rental_page/user_rental_screen.dart';
import 'package:velocy_user_app/view/pool/dashboard/ui/page/pool_dashboard.dart';

import '../../../utils/svgImage.dart';

class UserBottomButton extends StatelessWidget {
  UserBottomButton({super.key, required this.selectedInd});

  final RxInt selectedInd;

  final RxList _children =
      [
        UserBookRideScreen(),
        RentalPage(),
        PoolDashboard(),
        UserCoprateScreen(),
      ].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: AppColors.appWhiteColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.appWhiteColor,
            body: _children[selectedInd.value],
            bottomNavigationBar: Container(
              height: 62,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.appWhiteColor,
                border: const Border(
                  top: BorderSide(
                    color: Color(0xFFE5E5E5),
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    index: 0,
                    label: "Book Ride",
                    iconPath: SvgImage.bookRide.value,
                    onTap: () => selectedInd(0),
                  ),
                  _buildNavItem(
                    index: 1,
                    label: "Rental",
                    iconPath: SvgImage.rental.value,
                    onTap: () => Get.toNamed(Routes.rentalDashboard.value),
                  ),
                  _buildNavItem(
                    index: 2,
                    label: "Pool",
                    iconPath: SvgImage.carPool.value,
                    onTap: () => Get.toNamed(Routes.poolDashboard.value),
                  ),
                  _buildNavItem(
                    index: 3,
                    label: "Corporate",
                    iconPath: SvgImage.corparate.value,
                    onTap: () => Get.toNamed(Routes.coopratedDashboard.value),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(iconPath, height: 20, width: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTextStyle.small12SizeText.copyWith(
              fontFamily:
                  selectedInd.value == index
                      ? FontFamily.interSemiBold
                      : FontFamily.interRegular,
            ),
          ),
        ],
      ),
    );
  }
}
