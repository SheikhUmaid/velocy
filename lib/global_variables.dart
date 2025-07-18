
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/utils/app_colors.dart';

class Global {



  showSnackBar(String? title, String? message) {
    return Get.snackbar(
      '$title',
      '$message',
      margin: EdgeInsets.all(10.w),
      backgroundGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 52, 100],
        colors: <Color>[
          Color(0xff353A40),
          Color(0xff16171B),
          Color(0xff353A40),
        ],
        tileMode: TileMode.mirror,
      ),
      colorText: AppColors.appBlackColor,
    );
  }

  RxBool isLoading = false.obs;

  Future? nextPage(Widget page) {
    return Get.to(page,
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500));
  }

  Future? nextPageReplace(Widget page) {
    return Get.offAll(() => page,
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300));
  }

  void nextPageFade(context, Widget page) {
    Get.to(page, transition: Transition.fade);
  }

  void goBack() {
    Get.back();
  }

  double height = Get.height;
  double width = Get.width;

  Future<void> delay(int time) async {
    await Future.delayed(Duration(seconds: time), () {});
  }
}

Future<void> delay(int time) async {
  await Future.delayed(Duration(seconds: time), () {});
}