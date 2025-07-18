import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({
    super.key,
    required this.onChange,
    required this.height,
    this.defaultValue,
    required this.array,
    this.margin,

    this.hintText,
    this.icon,
    this.borderWidth = 2.0,
    // required this.color,
    this.borderColor,
  });

  final Function(String?) onChange;
  final String? defaultValue;
  final List<String> array;
  final double? margin;
  final Icon? icon;
  final double height;
  final String? hintText;
  final double borderWidth;
  // final Color color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          width: double.infinity,
          padding: EdgeInsets.only(left: 13.w, right: 13.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Color(0xFFE5E7EB),
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(8.0.r),
            value: defaultValue,
            dropdownColor: AppColors.appWhiteColor,
            underline: Container(),
            hint: Text(
              '$hintText',
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: AppColors.appBlackColor,
              ),
            ),
            icon:
                icon ??
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: Color(0xFF5E5E5E),
                ),
            isExpanded: true,
            items:
                array.toSet().toList().map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular
                      ),
                    ),
                  );
                }).toList(),
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}
