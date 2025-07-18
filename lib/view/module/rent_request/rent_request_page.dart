import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/rent_request/component/rental_request_text_widget.dart';
import 'package:velocy_user_app/view/notification/component/notification_button.dart';

class RentRequestPage extends StatelessWidget {
  const RentRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Rental Request",
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Request #2025-0123",
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: const Color.fromRGBO(115, 115, 115, 1),
                  ),
                ),
                Text(
                  "Waiting Approval",
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: const Color.fromRGBO(115, 115, 115, 1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SvgPicture.asset(SvgImage.profile.value, height: 45),
                const SizedBox(width: 11),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Anderson",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                    Text(
                      "JID: USR-2025-789",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: const Color.fromRGBO(115, 115, 115, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 18),
            Text(
              "Vehicle Details",
              style: AppTextStyle.medium18SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            SizedBox(height: 10),
            RentelRequestTextWidget(
              title: 'Vehicle Number',
              subTitle: 'ABC 1234',
            ),
            SizedBox(height: 8),
            RentelRequestTextWidget(title: 'Model', subTitle: 'Toyota Camry'),
            SizedBox(height: 40),
            Text(
              "Rental Period",
              style: AppTextStyle.medium18SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            SizedBox(height: 10),
            RentelRequestTextWidget(
              title: 'Start Date',
              subTitle: 'Jan 15, 2025',
            ),
            SizedBox(height: 8),
            RentelRequestTextWidget(
              title: 'End Date',
              subTitle: 'Jan 20, 2025',
            ),
            SizedBox(height: 8),
            RentelRequestTextWidget(title: 'Duration', subTitle: '5 days'),
            SizedBox(height: 20),

            SizedBox(
              height: 48,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.pickUpDetails.value);
                },
                child: NotificationActionButton(
                  title: 'Pick Up',
                  backgroungColors: Colors.black,
                  colors: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              height: 48,
              child: NotificationActionButton(
                title: 'Cancel Request',
                backgroungColors: AppColors.boxColors,
                colors: AppColors.appBlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
