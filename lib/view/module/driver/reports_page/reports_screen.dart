import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/reports_page/report_card.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "What do you want to report?"),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            children: [
              ReportTitle(
                title: 'Scam activity',
                SubTitle: 'Report suspicious or fraudulent behavior',
                image: SvgImage.scam.value,
                onPress: () {
                  Get.toNamed(Routes.reportSubmitPage.value);
                },
              ),
              SizedBox(height: 18),
              ReportTitle(
                title: 'Unsafe or inappropriate behaviour',
                SubTitle: 'Report concerning conduct or safety issues',
                image: SvgImage.unsafe.value,
                onPress: () {},
              ),
              SizedBox(height: 18),
              ReportTitle(
                title: 'Issue with ride or profile',
                SubTitle: 'Report problems with service or account',
                image: SvgImage.car.value,
                onPress: () {},
              ),
              SizedBox(height: 18),
              ReportTitle(
                title: 'Suspicious payments or pricing',
                SubTitle: 'Report payment irregularities or concerns',
                onPress: () {},
                image: SvgImage.card.value,
              ),
              SizedBox(height: 18),
              Text(
                "Your report will be handled confidentially and reviewed by our team",
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
