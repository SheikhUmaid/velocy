import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/driver_auth_page/cubit/driver_registration_cubit.dart';
import 'package:velocy_user_app/widgets/my_textfield.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class DriverRegistrationScreen extends StatefulWidget {
  const DriverRegistrationScreen({super.key});

  @override
  State<DriverRegistrationScreen> createState() =>
      _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  final RxInt vehicleType = 0.obs;

  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController vehicleTypeTextController =
      TextEditingController();
  final TextEditingController vehicleYearController = TextEditingController();
  final TextEditingController carCompanyController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBgColor,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColors.appBlackColor),
        ),
        title: Text(
          "Velocy",
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.poppinsBold,
          ),
        ),
      ),
      body: BlocConsumer<DriverRegistrationCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonStateSuccess) {
            Get.toNamed(Routes.documentPage.value);
          } else if (state is CommonError) {
            Get.snackbar(
              "Error",
              state.message,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      "Ready to host rides",
                      style: AppTextStyle.medium24SizeText.copyWith(
                        fontSize: 24,
                        fontFamily: FontFamily.interBold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Provide your vehicle information to host rides.",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: Color(0xFF9B9B9B),
                      ),
                    ),
                    SizedBox(height: 26),
                    buildInput(
                      "Vehicle Number",
                      "TN 01 A 0000",
                      vehicleNumberController,
                    ),
                    SizedBox(height: 13),
                    Text(
                      "Choose Vehicle Type",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interSemiBold,
                      ),
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(3, (index) {
                        final images = [
                          AppImage.bike.value,
                          AppImage.taxi.value,
                          AppImage.auto.value,
                          // "assets/app_images/cab_vector.png"
                          // AppImage.auto.value,
                        ];
                        return GestureDetector(
                          onTap: () => vehicleType(index),
                          child: Container(
                            height: 100,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.appGrayColorF2,
                              border: Border.all(
                                color:
                                    vehicleType.value == index
                                        ? AppColors.appBlackColor
                                        : AppColors.appWhiteColor,
                                width: 2.87,
                              ),
                              image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 13),
                    buildInput(
                      "Vehicle Type",
                      "Scooter",
                      vehicleTypeTextController,
                    ),
                    SizedBox(height: 26),
                    buildInput("Year", "2017 Passing", vehicleYearController),
                    SizedBox(height: 13),
                    buildInput(
                      "Car Company",
                      "Honda / TVS",
                      carCompanyController,
                    ),
                    SizedBox(height: 13),
                    buildInput("Car Model", "Activa 5G", carModelController),
                    SizedBox(height: 26),
                    Align(
                      alignment: Alignment.center,
                      child:
                          state is CommonLoading
                              ? CircularProgressIndicator()
                              : PrimaryButton(
                                onPressed: () {
                                  context
                                      .read<DriverRegistrationCubit>()
                                      .driverRegister(
                                        vehicle_number:
                                            vehicleNumberController.text,
                                        vehicle_type:
                                            vehicleTypeTextController.text,
                                        year: vehicleYearController.text,
                                        car_company: carCompanyController.text,
                                        car_model: carModelController.text,
                                      );
                                },
                                text: "Next",
                                width: 87,
                                height: 42,
                              ),
                    ),
                    SizedBox(height: 26),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInput(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interSemiBold,
          ),
        ),
        SizedBox(height: 13),
        MyTextFormField(
          height: 50,
          hintText: hint,
          padding: const EdgeInsets.only(left: 13),
          controller: controller,
        ),
      ],
    );
  }
}
