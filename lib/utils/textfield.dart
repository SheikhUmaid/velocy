import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class PrimaryTextField extends HookWidget {
  final String? hintText;
  final String? initialValue;
  final String? keyName;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxLine;
  final String? label;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? innerIcon;
  final double? borderRadius;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool? isReadOnly;
  final GlobalKey<FormBuilderFieldState>? fieldKey;
  final bool enableBorder;
  final Color? fillColor;
  final TextEditingController? controller;
  final double? labelHeight;
  final bool enable;
  final EdgeInsets? contentPadding;
  final Function()? ontap;

  const PrimaryTextField({
    this.enable = true,
    this.innerIcon,
    this.label,
    this.maxLine,
    this.validator,
    this.initialValue,
    this.borderRadius,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.hintText,
    this.keyName,
    this.controller,
    this.fillColor,
    this.labelHeight,
    this.enableBorder = false,
    this.isReadOnly,
    this.isPassword = false,
    this.textInputType,
    this.maxLength,
    this.ontap,
    this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(isPassword);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(prefixIcon),
                  ),
                Text(label!, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        if (label != null) SizedBox(height: labelHeight ?? 10),
        Container(
          alignment: Alignment.centerLeft,
          child: FormBuilderTextField(
            onTap: ontap,
            controller: controller,
            enabled: enable,
            key: fieldKey,
            initialValue: initialValue,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: isPasswordVisible.value,
            style: Theme.of(context).textTheme.bodyLarge,
            readOnly: isReadOnly ?? false,
            decoration: InputDecoration(
              prefixIcon: innerIcon,
              fillColor: fillColor ?? Colors.white,
              isDense: true,
              errorText: errorText,
              counterText: "",
              errorMaxLines: 2,
              contentPadding:
                  contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              hintText: hintText ?? "",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 16,
                fontFamily: FontFamily.interRegular,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 8.0),
                ),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 8.0),
                ),
                borderSide: BorderSide(
                  color:
                      enableBorder
                          ? AppColors.appBlackColor
                          : AppColors.appBlackColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 8.0),
                ),
                borderSide: const BorderSide(color: AppColors.boxColors),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 5.0),
                ),
                borderSide: BorderSide(
                  color:
                      enableBorder ? AppColors.boxColors : AppColors.boxColors,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 8.0),
                ),
                borderSide: BorderSide(
                  color:
                      enableBorder ? AppColors.boxColors : AppColors.boxColors,
                ),
              ),
              suffixIcon:
                  isPassword
                      ? GestureDetector(
                        onTap: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Icon(
                            isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      )
                      : Container(
                        padding: const EdgeInsets.all(20),
                        child: suffixIcon ?? const Text(''),
                      ),
            ),
            maxLines: maxLine ?? 1,
            maxLength: maxLength,
            validator: validator,
            name: keyName ?? "null",
          ),
        ),
      ],
    );
  }
}

class SecondaryTextField extends HookWidget {
  final String? hintTxt;
  final String? initialValue;
  final String? keyName;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxLine;
  final String? label;
  final String? errorText;
  final Widget? prefixIcon;
  final double? borderRadius;
  final Widget? suffixIcon;
  final bool? isReadOnly;
  final GlobalKey<FormBuilderFieldState>? fieldKey;
  final bool enableBorder;
  final Color? fillColor;
  final TextEditingController? controller;
  final double? labelHeight;
  final bool isPassword;
  final double verticalPadding;
  final double horizontalPadding;

  // final Function onSaved;

  const SecondaryTextField({
    required this.onSaved,
    this.label,
    this.validator,
    this.initialValue,
    this.borderRadius,
    this.errorText,
    this.isPassword = false,
    this.prefixIcon,
    this.maxLine,
    this.suffixIcon,
    this.hintTxt,
    this.keyName,
    this.controller,
    this.fillColor,
    this.labelHeight,
    this.enableBorder = false,
    this.isReadOnly,
    this.textInputType,
    this.maxLength,
    this.fieldKey,
    this.verticalPadding = 0,
    this.horizontalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(isPassword);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: prefixIcon,
                ),
              Text('$label'),
            ],
          ),
        SizedBox(height: labelHeight),
        Container(
          alignment: Alignment.centerLeft,
          child: FormBuilderTextField(
            controller: controller,
            key: fieldKey,
            initialValue: initialValue,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: isPasswordVisible.value,
            style: Theme.of(context).textTheme.headlineSmall,
            readOnly: isReadOnly ?? false,
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColor ?? Colors.white,
              errorText: errorText,
              counterText: "",
              errorMaxLines: 2,
              contentPadding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding,
              ),
              // labelText:
              hintText: hintTxt ?? "",
              // hintStyle:Theme.of(context).textTheme.bodyText1 ,
              // "Email or Phone",
              // labelStyle: AppTextStyle.textboxtext,
              filled: true,
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green.withOpacity(0.5)),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              suffixIcon:
                  isPassword
                      ? GestureDetector(
                        onTap: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Icon(
                            isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      )
                      : Container(
                        padding: const EdgeInsets.all(15),
                        child: suffixIcon ?? const Text(''),
                      ),
            ),
            onSaved: onSaved,
            maxLength: maxLength,
            maxLines: maxLine ?? 1,
            validator: validator,
            name: keyName ?? "null",
          ),
        ),
      ],
    );
  }
}
