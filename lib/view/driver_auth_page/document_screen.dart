import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_toast.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/driver_auth_page/cubit/driver_document_cubit.dart';
import 'package:velocy_user_app/view/driver_auth_page/document_upload_sections.dart';
import 'package:velocy_user_app/view/module/driver/driver_bottom_button.dart';
import 'package:velocy_user_app/widgets/my_textfield.dart';

import 'package:velocy_user_app/widgets/primary_button.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final TextEditingController licensePlateNumberCintroller =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<File> vehicleRegistrationFiles = [];
  final List<File> driverLicenseFiles = [];
  final List<File> vehicleInsuranceFiles = [];

  void onSubmit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<DriverDocumentUploadCubit>();

      await cubit.uploadDocuments(
        licensePlateNumber: licensePlateNumberCintroller.text,
        vehicleRegistrationDocs: vehicleRegistrationFiles,
        driverLicenses: driverLicenseFiles,
        vehicleInsurances: vehicleInsuranceFiles,
      );

      // If upload was successful, trigger becomeDriver
      final currentState = cubit.state;
      if (currentState is CommonStateSuccess) {
        await cubit.becomeDriver();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverDocumentUploadCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonStateSuccess) {
          CustomToast.success(message: "Document Upload Successfully");
          Get.to(() => DriverBottomButton(selectedInd: 0.obs));
        }
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
      },
      child: Form(
        key: _formKey,
        child: Container(
          color: AppColors.appBgColor,
          child: SafeArea(
            child: Scaffold(
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
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Document Verification",
                            style: AppTextStyle.medium24SizeText.copyWith(
                              fontFamily: FontFamily.interBold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Provide your vehicle information to host rides.",
                            style: AppTextStyle.small14SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                              color: const Color(0xFF9B9B9B),
                            ),
                          ),
                          const SizedBox(height: 26),
                          Text(
                            "Verify Documents for TN 01 A 0000",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.interSemiBold,
                              color: AppColors.appDarkGrayColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // License Plate
                    Container(
                      height: 110,
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.appWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appBlackColor.withOpacity(0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "License Plate Number",
                            style: AppTextStyle.small14SizeText,
                          ),
                          MyTextFormField(
                            height: 50,
                            hintText: "Enter plate number",
                            controller: licensePlateNumberCintroller,
                          ),
                        ],
                      ),
                    ),

                    // Upload Sections
                    DocumentUploadSections(
                      title: "Vehicle Registration",
                      hintText: "Upload registration document",
                      formatNote: "PDF, JPG or PNG (max. 5MB)",
                      iconPath: SvgImage.upReg.value,
                      onFilePicked: (file) {
                        setState(() {
                          vehicleRegistrationFiles.add(file);
                        });
                      },
                    ),
                    DocumentUploadSections(
                      title: "Driver's License",
                      hintText: "Upload driver's license",
                      formatNote: "PDF, JPG or PNG (max. 5MB)",
                      iconPath: SvgImage.upLic.value,
                      onFilePicked: (file) {
                        setState(() {
                          driverLicenseFiles.add(file);
                        });
                      },
                    ),
                    DocumentUploadSections(
                      title: "Vehicle Insurance",
                      hintText: "Upload insurance document",
                      formatNote: "PDF, JPG or PNG (max. 5MB)",
                      iconPath: SvgImage.upDoc.value,
                      onFilePicked: (file) {
                        setState(() {
                          vehicleInsuranceFiles.add(file);
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Bottom Button
              bottomNavigationBar: Container(
                height: 89,
                padding: const EdgeInsets.all(16.5),
                decoration: BoxDecoration(
                  color: AppColors.appWhiteColor,
                  border: Border(
                    top: BorderSide(color: AppColors.appGrayColorE5),
                  ),
                ),
                child: PrimaryButton(
                  height: 56,
                  onPressed: onSubmit,

                  // // Validate before navigation
                  // Get.to(() => DriverBottomButton(selectedInd: 0.obs));
                  text: "Finish",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interSemiBold,
                    color: AppColors.appTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
