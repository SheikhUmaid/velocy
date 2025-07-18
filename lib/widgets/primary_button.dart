import 'package:velocy_user_app/global_variables.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.width,
    this.color,
    this.border,
    this.style,
    this.borderRadius,
  });

  final Function()? onPressed;
  final String text;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxBorder? border;
  final Color? color;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 48,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ??  AppColors.appBlackColor,
          borderRadius: BorderRadius.circular(borderRadius ??6.0),
          border: border
        ),
        child: Center(
          child: Text(
            text,
            style: style ??  AppTextStyle.medium18SizeText.copyWith(
              fontFamily: FontFamily.interSemiBold,
              color: AppColors.appTextColor,
              letterSpacing: -0.4
            ),
          ),
        ),
      ),
    );
  }
}
