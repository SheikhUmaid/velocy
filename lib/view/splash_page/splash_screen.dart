import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/module/user/user_bottom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoadingAnimation();
  }

  void _startLoadingAnimation() {
    const duration = Duration(seconds: 2); // Changed to 2 seconds
    const steps = 100;
    final interval = duration.inMilliseconds ~/ steps;

    Timer.periodic(Duration(milliseconds: interval), (timer) {
      setState(() {
        _progressValue += 1 / steps;
        if (_progressValue >= 1.0) {
          timer.cancel();
          _initializeAuth();
          // Get.offAllNamed(Routes.permissionPage.value);
        }
      });
    });
  }

  Future<void> _initializeAuth() async {
    final authRepository = RepositoryProvider.of<AuthRepository>(context);
    await authRepository.initial();

    final isLoggedIn = authRepository.isLoggedIn.value;
    final userRole = authRepository.userRole.value;

    // 👇 Print the role for debugging
    debugPrint('🔑 Logged in: $isLoggedIn, Role: $userRole');

    _navigateBasedOnRole(isLoggedIn, userRole);
  }

  void _navigateBasedOnRole(bool isLoggedIn, String userRole) {
    Future.delayed(const Duration(seconds: 1), () {
      if (isLoggedIn) {
        switch (userRole) {
          case 'driver':
            Get.toNamed(Routes.driverHomePage.value);
            break;
          case 'rider':
            Get.offAll(UserBottomButton(selectedInd: 0.obs));
            break;
          default:
            Get.toNamed(Routes.permissionPage.value);
        }
      } else {
        Get.toNamed(Routes.permissionPage.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Velocy",
              style: TextStyle(
                color: AppColors.appBlackColor,
                fontSize: 48,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                fontFamily: FontFamily.instrumentSansBoldItalic,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 194,
              height: 7,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF393939),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Text(
          "Made in India",
          textAlign: TextAlign.center,
          style: AppTextStyle.medium20SizeText.copyWith(
            color: Color(0xFFA1A1A1),
            fontFamily: FontFamily.poppinsRegular,
          ),
        ),
      ),
    );
  }
}
