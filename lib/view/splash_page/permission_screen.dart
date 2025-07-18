import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBgColor,
        body: _buildBackgroundImage(),
        bottomNavigationBar: _buildPermissionBottomSheet(),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      AppImage.permission.value,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildPermissionBottomSheet() {
    return SizedBox(
      height: 229,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buildPermissionReasons(), _buildAllowButton()],
      ),
    );
  }

  Widget _buildPermissionReasons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPermissionItem(
          icon: SvgImage.location.value,
          text: "To locate you and get rides easily",
        ),
        const SizedBox(height: 12),
        // Phone permission UI — commented out for now
        _buildPermissionItem(
          icon: SvgImage.phone.value,
          text: "To verify your account and secure it",
        ),
      ],
    );
  }

  Widget _buildPermissionItem({required String icon, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ],
    );
  }

  Widget _buildAllowButton() {
    return PrimaryButton(
      height: 42,
      width: 177,
      onPressed: () async {
        await _requestPermissions();
      },
      text: "Allow Permission",
    );
  }

  Future<void> _requestPermissions() async {
    final statuses =
        await [
          Permission.location,
          // Permission.phone, // 🔒 Phone permission skipped for now
        ].request();

    final isLocationGranted = statuses[Permission.location]?.isGranted ?? false;
    // final isPhoneGranted = statuses[Permission.phone]?.isGranted ?? false;

    if (isLocationGranted /* && isPhoneGranted */ ) {
      Get.toNamed(Routes.languagePage.value);
    } else if (statuses.values.any((status) => status.isPermanentlyDenied)) {
      Get.snackbar(
        "Permission Denied",
        "Please enable permissions from settings.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      await openAppSettings();
    } else {
      Get.snackbar(
        "Permission Required",
        "Please allow location permission to continue.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
