import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/rider_chat/component/recived_bubble.dart';
import 'package:velocy_user_app/view/module/driver/rider_chat/component/send_bubble.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBgColor,

        body: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(SvgImage.profile.value),
                      SizedBox(width: 10),
                      ReceiverBubble(
                        message:
                            'Im on my way to pick you \nI ll be there in about 5 minutes',
                        time: '10:23 AM',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SendBubble(
                        message:
                            " Perfect! I'm waiting at the \nGreat! I'm waiting near the coffee shop",
                        time: "10:24 AM",
                      ),
                      SizedBox(width: 10),
                      SvgPicture.asset(SvgImage.profile.value),
                    ],
                  ),

                  Row(
                    children: [
                      SvgPicture.asset(SvgImage.profile.value),
                      SizedBox(width: 10),
                      ReceiverBubble(
                        message:
                            'Im on my way to pick you \nI ll be there in about 5 minutes',
                        time: '10:23 AM',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }
}

Widget _buildInputBar() {
  return SafeArea(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          SvgPicture.asset(SvgImage.microPhone.value, width: 20, height: 20),

          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF6F6F6),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset(SvgImage.gallery.value, width: 20, height: 20),
          const SizedBox(width: 16),
          SvgPicture.asset(SvgImage.send2.value, width: 21, height: 40),
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
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, size: 25),
            ),
            GestureDetector(
              // onTap: () => _scaffoldKey.currentState?.openDrawer(),
              child: SvgPicture.asset(SvgImage.profile.value),
            ),
            const SizedBox(width: 22),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sarah Parker",
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                Text(
                  "Pickup Confirmed",
                  style: AppTextStyle.small12SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: AppColors.appDarkGrayColor73,
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () {
            // Get.toNamed(Routes.notificationPage.value);
          },
          child: SvgPicture.asset(SvgImage.call.value),
        ),
        SizedBox(width: 19),
        InkWell(
          onTap: () {
            // Get.toNamed(Routes.notificationPage.value);
          },
          child: SvgPicture.asset(SvgImage.location.value),
        ),
      ],
    ),
  );
}
