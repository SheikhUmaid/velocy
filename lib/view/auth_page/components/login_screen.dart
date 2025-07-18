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
import 'package:velocy_user_app/view/auth_page/cubit/login_cubit.dart';
import 'package:velocy_user_app/view/module/user/user_bottom_button.dart';
import 'package:velocy_user_app/widgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController(
    // text: "+919480507875",
  );
  final TextEditingController passwordController = TextEditingController(
    // text: "112233",
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  login() async {
    if (_formKey.currentState!.validate()) {
      // FocusScope.of(context).unfocus();
      context.read<LoginCubit>().login(
        password: passwordController.text,
        phoneNumber: phoneController.text,
      );
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccessWithRole) {
          switch (state.role.toLowerCase()) {
            case 'driver':
              Get.offAllNamed(Routes.driverHomePage.value);
              break;
            case 'rider':
              // Get.offAllNamed();
              Get.offAll(UserBottomButton(selectedInd: 0.obs));
              break;

            default:
              Get.snackbar("Error", "Unknown role: ${state.role}");
          }
        }
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
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
                        Expanded(
                          child: PrimaryTextField(
                            hintText: "Enter phone number",
                            controller: phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone Number is Required';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is Required";
                    }
                  },
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: SvgPicture.asset(SvgImage.eye.value),
                  ),
                ),
                const SizedBox(height: 22),
                _buildLoginWithOtpText(),
                const SizedBox(height: 40),
                // PrimaryButton(
                //   onPressed: login,
                //   text: "Login",
                //   style: AppTextStyle.small16SizeText.copyWith(
                //     fontFamily: FontFamily.interRegular,
                //     color: AppColors.appWhiteColor,
                //   ),

                // ),
                PrimaryButton(
                  onPressed: login,
                  title: "Login",
                  widget:
                      state is CommonLoading
                          ? const CustomCupertinoIndicator()
                          : null,
                  color: AppColors.appBlackColor,
                  height: 48,
                  radius: 8,
                ),
                const SizedBox(height: 22),
                _buildDividerWithText(),
                const SizedBox(height: 31),
                _buildSocialLoginButtons(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCountryCodeDropdown() {
    return Container(
      height: 55,
      width: 78,
      margin: const EdgeInsets.only(right: 13),
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

  Widget _buildLoginWithOtpText() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        "Login with OTP",
        style: AppTextStyle.small14SizeText.copyWith(
          fontFamily: FontFamily.interRegular,
        ),
      ),
    );
  }

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
