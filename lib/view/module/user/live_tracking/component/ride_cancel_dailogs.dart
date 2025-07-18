import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

void showCancelRideDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: SvgPicture.asset(
                  SvgImage.cancel.value,
                  height: 32,
                  width: 32,
                ),
                // child: Icon(Icons.close, size: 32, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Title Text
              Text(
                'Oops! Are you sure you want to cancel your ride?',
                textAlign: TextAlign.center,
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 24),

              // Yes, Cancel it! button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Add cancel logic here
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Yes, Cancel it!',
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appBgColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // No, Keep Searching! button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No, Keep Searching !',
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
