import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_toast.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/utils/textfield.dart';
import 'package:velocy_user_app/view/auth_page/cubit/register_cubit.dart';
import 'package:velocy_user_app/widgets/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController(
    text: "+918217792169",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "New@123",
  );
  final TextEditingController conformPassword = TextEditingController(
    text: "New@123",
  );
  final TextEditingController otp = TextEditingController(text: "112233");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  register() async {
    if (_formKey.currentState!.validate()) {
      // FocusScope.of(context).unfocus();
      context.read<RegisterCubit>().register(
        password: passwordController.text,
        phoneNumber: phoneController.text,
        confirmpassword: conformPassword.text,
        otp: otp.text,
      );
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    conformPassword.dispose();
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonStateSuccess) {
          Get.toNamed(Routes.userProfilePage.value);
          CustomToast.success(message: "Register SucessFully");
        }
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      _buildCountryCodeDropdown(),
                      const SizedBox(width: 13),
                      Expanded(
                        child: MyTextFormField(
                          hintText: "Enter phone number",
                          controller: phoneController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Text(
                "OTP",
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 13),
              PrimaryTextField(
                hintText: "Enter OTP",
                controller: otp,
                isPassword: true,
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: SvgPicture.asset(SvgImage.eye.value),
                ),
              ),
              const SizedBox(height: 26),
              Text(
                "Password",
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 13),
              PrimaryTextField(
                hintText: "Enter Password",
                isPassword: true,
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: SvgPicture.asset(SvgImage.eye.value),
                ),
                controller: passwordController,
              ),
              const SizedBox(height: 26),
              Text(
                "Confirm Password",
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 13),
              PrimaryTextField(
                hintText: "Enter Password",
                controller: conformPassword,
                isPassword: true,
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: SvgPicture.asset(SvgImage.eye.value),
                ),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                onPressed: register,

                title: "Continue",
                height: 48,
                radius: 8,
                color: AppColors.appBlackColor,
              ),
              const SizedBox(height: 22),
              _buildDividerWithText(),
              const SizedBox(height: 31),
              _buildSocialLoginButtons(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryCodeDropdown() {
    return Container(
      height: 42,
      width: 78,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.appBorderGrayColor,
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "+91",
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.appBlackColor,
          ),
        ],
      ),
    );
  }

  // Widget _buildContinueButton() {
  //   return PrimaryButton(
  //     onPressed: () {
  //       Get.toNamed(Routes.userProfilePage.value);
  //     },
  //     text: "Continue",
  //     style: AppTextStyle.small16SizeText.copyWith(
  //       fontFamily: FontFamily.interRegular,
  //       color: AppColors.appWhiteColor,
  //     ),
  //   );
  // }

  Widget _buildDividerWithText() {
    return Row(
      children: [
        const Expanded(
          child: Divider(height: 1, color: AppColors.appBorderGrayColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "or continue with",
            style: AppTextStyle.small14SizeText.copyWith(
              color: const Color(0xFF737373),
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ),
        const Expanded(
          child: Divider(height: 1, color: AppColors.appBorderGrayColor),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      children: [
        _buildSocialButton(SvgImage.google.value),
        const SizedBox(width: 12),
        _buildSocialButton(SvgImage.apple.value),
        const SizedBox(width: 12),
        _buildSocialButton(SvgImage.facebook.value),
      ],
    );
  }

  Widget _buildSocialButton(String iconPath) {
    return Expanded(
      child: Container(
        height: 46,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.appBorderGrayColor),
        ),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
