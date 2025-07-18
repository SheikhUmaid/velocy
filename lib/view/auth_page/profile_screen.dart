import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_toast.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/auth_page/cubit/update_profile_cubit.dart';
import 'package:velocy_user_app/widgets/my_textfield.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final RxInt selectedValue = 1.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  File? profileImage;
  File? adharCardImage;
  String addressType = "Permanent";

  Future<File> compressImage(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return file;

    final resized = img.copyResize(image, width: 800);
    final compressed = img.encodeJpg(resized, quality: 50);
    final compressedFile = await file.writeAsBytes(compressed, flush: true);
    print('Compressed image size: ${compressedFile.lengthSync() / 1024} KB');
    return compressedFile;
  }

  Future<void> pickImage(bool isProfile) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      final compressed = await compressImage(file);
      setState(() {
        if (isProfile) {
          profileImage = compressed;
        } else {
          adharCardImage = compressed;
        }
      });
    }
  }

  void submitProfile(BuildContext context) {
    final cubit = context.read<ProfileUpdateCubit>();

    if (nameController.text.isEmpty ||
        streetController.text.isEmpty ||
        areaController.text.isEmpty ||
        profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all required fields.")),
      );
      return;
    }

    final gender =
        selectedValue.value == 1
            ? "Male"
            : selectedValue.value == 2
            ? "Female"
            : "Others";

    cubit.updateProfile(
      username: nameController.text,
      profile: profileImage!,
      gender: gender,
      street: streetController.text,
      area: areaController.text,
      adharcard: adharCardImage ?? File(''),
      address_type: addressType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileUpdateCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonStateSuccess) {
          CustomToast.success(message: "Profile updated successfully");
          Get.toNamed(Routes.onBoardingPage.value);
        } else if (state is CommonError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.appBgColor,
          appBar: AppBar(
            backgroundColor: AppColors.appBgColor,
            elevation: 1,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.appBlackColor),
              onPressed: () => Get.back(),
            ),
            title: Text(
              "Complete Profile",
              style: AppTextStyle.medium18SizeText.copyWith(
                fontFamily: FontFamily.poppinsBold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "One last step to\nfinish",
                    style: AppTextStyle.extraLarge34SizeText.copyWith(
                      fontFamily: FontFamily.interBold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Ready for booking, one step left",
                    style: AppTextStyle.medium18SizeText.copyWith(
                      color: Color(0xFF9B9B9B),
                    ),
                  ),
                  SizedBox(height: 26),

                  // Profile Picker
                  GestureDetector(
                    onTap: () => pickImage(true),
                    child: Stack(
                      children: [
                        Container(
                          height: 92,
                          width: 92,
                          decoration: BoxDecoration(
                            color: AppColors.appWhiteColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.appBlackColor.withOpacity(
                                  0.13,
                                ),
                                blurRadius: 27.9,
                              ),
                            ],
                          ),
                          child:
                              profileImage != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      profileImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : Icon(
                                    Icons.person,
                                    color: AppColors.appTextDarkGrayColor,
                                    size: 40,
                                  ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 34,
                            width: 34,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.appWhiteColor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.appBlackColor.withOpacity(
                                    0.13,
                                  ),
                                  blurRadius: 14.9,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(SvgImage.upload.value),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 26),

                  // Form Fields
                  Text("User name", style: AppTextStyle.small16SizeText),
                  SizedBox(height: 13),
                  MyTextFormField(
                    controller: nameController,
                    hintText: "Enter your name",
                    height: 50,
                    padding: EdgeInsets.only(left: 13),
                  ),

                  SizedBox(height: 26),
                  Text("Gender", style: AppTextStyle.small16SizeText),
                  Row(
                    children: List.generate(3, (index) {
                      final label = ["Male", "Female", "Others"][index];
                      final value = index + 1;
                      return Row(
                        children: [
                          Radio<int>(
                            value: value,
                            groupValue: selectedValue.value,
                            fillColor: MaterialStateProperty.all(
                              AppColors.appBlackColor,
                            ),
                            onChanged: (val) {
                              setState(() {
                                selectedValue.value = val!;
                              });
                            },
                          ),
                          Text(label, style: AppTextStyle.small16SizeText),
                        ],
                      );
                    }),
                  ),

                  SizedBox(height: 26),
                  Text("Address", style: AppTextStyle.small16SizeText),
                  SizedBox(height: 13),
                  Text(
                    "House / Flat / Block No.",
                    style: AppTextStyle.small14SizeText,
                  ),
                  SizedBox(height: 13),
                  MyTextFormField(
                    controller: streetController,
                    hintText: "Enter your address",
                    height: 50,
                    padding: EdgeInsets.only(left: 13),
                  ),

                  SizedBox(height: 26),
                  Text(
                    "Area / Location / City",
                    style: AppTextStyle.small14SizeText,
                  ),
                  SizedBox(height: 13),
                  MyTextFormField(
                    controller: areaController,
                    hintText: "Enter your address",
                    height: 50,
                    padding: EdgeInsets.only(left: 13),
                  ),

                  SizedBox(height: 26),

                  // Aadhaar Upload
                  GestureDetector(
                    onTap: () => pickImage(false),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.appWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appBlackColor.withOpacity(0.05),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Adhar Card (Optional)",
                            style: AppTextStyle.small14SizeText,
                          ),
                          SizedBox(height: 10),
                          adharCardImage != null
                              ? Image.file(adharCardImage!, height: 80)
                              : SvgPicture.asset(SvgImage.div.value),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 26),
                  Text("Address Type", style: AppTextStyle.small16SizeText),
                  SizedBox(height: 13),
                  Row(
                    children: [
                      PrimaryButton(
                        onPressed:
                            () => setState(() => addressType = "Permanent"),
                        text: "Permanent",
                        width: 100,
                        height: 40,
                        color:
                            addressType == "Permanent"
                                ? AppColors.appBlackColor
                                : Colors.transparent,
                        style: AppTextStyle.small14SizeText.copyWith(
                          color:
                              addressType == "Permanent"
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                      SizedBox(width: 13),
                      PrimaryButton(
                        onPressed: () => setState(() => addressType = "Other"),
                        text: "Other",
                        width: 80,
                        height: 40,
                        color:
                            addressType == "Other"
                                ? AppColors.appBlackColor
                                : Colors.transparent,
                        border: Border.all(color: AppColors.appBlackColor),
                        style: AppTextStyle.small14SizeText.copyWith(
                          color:
                              addressType == "Other"
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 26),
                  Center(
                    child:
                        state is CommonLoading
                            ? CircularProgressIndicator()
                            : PrimaryButton(
                              onPressed: () => submitProfile(context),
                              text: "Finish",
                              width: 100,
                              height: 45,
                            ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
