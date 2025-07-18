import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.borderColor,
    this.enabledFlag,
    this.suffixIcon,
    this.prefixIcon,
    this.margin,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.padding,
    this.obscureText,
    this.height,
    this.validator,
  });

  final int? maxLines;
  final String hintText;
  final TextEditingController? controller;
  final Color? borderColor;
  final bool? enabledFlag;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final double? height;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.of(context).size.width < 600.0;
    return Container(
      height: height ?? 42,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.appBorderGrayColor,
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.only(left: 13, right: 13),
        child: TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: AppColors.appBlackColor,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          enabled: enabledFlag ?? true,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                suffixIcon != null ? EdgeInsets.only(top: 10) : EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              color: AppColors.appTextGrayColor,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
        ),
      ),
    );
  }
}
