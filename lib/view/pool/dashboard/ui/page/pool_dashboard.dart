import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/component/menu.dart';
import 'package:velocy_user_app/view/pool/dashboard/ui/widget/location_input_card.dart';
import 'package:velocy_user_app/view/pool/dashboard/ui/widget/pill_button_widget.dart';

class PoolDashboard extends StatefulWidget {
  @override
  _PoolDashboardState createState() => _PoolDashboardState();
}

class _PoolDashboardState extends State<PoolDashboard> {
  int seatCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      // key: _scaffoldKey,
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildAppBar(),
            SizedBox(height: 20),
            LocationInputCard(),
            const SizedBox(height: 16),

            /// Seat, Date & Time Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _boxDecoration(),
              child: Column(
                children: [
                  /// Seat Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Number of Seats",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      Row(
                        children: [
                          _circleButton("-", () {
                            if (seatCount > 1) setState(() => seatCount--);
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$seatCount',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          _circleButton("+", () {
                            setState(() => seatCount++);
                          }),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Date and Time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                          PillButtonWidget(
                            image: SvgImage.calendar.value,
                            text: "Today",
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                          PillButtonWidget(
                            image: SvgImage.time2.value,
                            text: "Now",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const SizedBox(height: 20),

            /// Empty Space (for future info)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              // height: 100,
              decoration: _boxDecoration(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "Choose Vichle Type",
                        style: AppTextStyle.medium18SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appTextColors,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 112,
                        width: 112,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColors.boxColors,
                          image: DecorationImage(
                            image: AssetImage(AppImage.bike.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 112,
                        width: 112,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColors.boxColors,
                          image: DecorationImage(
                            image: AssetImage(AppImage.bike.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 112,
                        width: 112,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColors.boxColors,
                          image: DecorationImage(
                            image: AssetImage(AppImage.bike.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Find Ride Button
            PrimaryButton(
              onPressed: () {
                Get.toNamed(Routes.availableRider.value);
              },
              title: "Find a Ride",
              height: 60,
              color: AppColors.appBlackColor,
              icon: Icon(Icons.search),
              radius: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.appWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.appBlackColor.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border(
          bottom: BorderSide(color: AppColors.appBlackColor.withOpacity(0.05)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.poolRequest.value);
                },
                child: SvgPicture.asset(SvgImage.profile.value),
              ),
              const SizedBox(width: 22),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, Alex",
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  Text(
                    "Welcome back",
                    style: AppTextStyle.small12SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appDarkGrayColor73,
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              // Get.toNamed(Routes.notificationPage.value);
            },
            child: SvgPicture.asset(SvgImage.notificationFill.value),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
    ],
  );

  Widget _circleButton(String text, VoidCallback onPressed) => GestureDetector(
    onTap: onPressed,
    child: CircleAvatar(
      radius: 16,
      backgroundColor: Colors.grey.shade200,
      child: Text(
        text,
        style: AppTextStyle.small16SizeText.copyWith(
          fontFamily: FontFamily.interRegular,
        ),
      ),
    ),
  );
}
