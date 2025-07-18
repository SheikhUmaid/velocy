import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/notification/component/notification_button.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

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
          "Arrival Notification",
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SvgPicture.asset(SvgImage.map.value),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgImage.profile.value,
                          height: 48,
                          width: 48,
                        ),

                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "John Doe",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),

                            Text(
                              "Passenger",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: const Color.fromRGBO(115, 115, 115, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgImage.location.value,
                          height: 16,
                          width: 12,
                        ),

                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Pickup Location",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),

                            Text(
                              "123 Main Street, New York, NY 10001",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: const Color.fromRGBO(115, 115, 115, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              NotificationActionButton(
                title: 'Notify Arrival',
                icons: SvgImage.notification.value,
                backgroungColors: Colors.black,
                colors: Colors.white,
              ),
              SizedBox(height: 10),
              NotificationActionButton(
                title: 'Call Passenger',
                icons: SvgImage.call.value,
                colors: Colors.black,
                backgroungColors: Color.fromRGBO(255, 255, 255, 1),
              ),
              SizedBox(height: 10),
              NotificationActionButton(
                title: 'Send Message',
                icons: SvgImage.sendMessage.value,
                colors: Colors.black,
                backgroungColors: Color.fromRGBO(255, 255, 255, 1),
              ),
              SizedBox(height: 15),
              NotificationActionButton(
                title: 'Begin',
                icons: SvgImage.send.value,
                backgroungColors: Colors.black,
                colors: Colors.white,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        SvgImage.time.value,
                        height: 16,
                        width: 12,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Arrived at: 10:45 AM",
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.appGrayColor,
                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: Row(
                      children: [
                        SvgPicture.asset(
                          SvgImage.cancel.value,
                          height: 16,
                          width: 12,
                        ),
                        SizedBox(width: 5),

                        Text(
                          "Cancel Ride",
                          style: AppTextStyle.small14SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
