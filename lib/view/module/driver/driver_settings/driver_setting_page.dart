import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/component/heading_title.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/component/profile_header.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/cubit/driver_profile_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/cubit/driver_vehicles_doc_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/driver_vechicles_doc_page.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/model/driver_settings_model.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/profile_screen.dart';

import '../../../../service/local_storage/secure_storage.dart';
import '../../../auth_page/model/profile_model.dart';

class DriverSettingPage extends StatefulWidget {
  const DriverSettingPage({super.key});

  @override
  State<DriverSettingPage> createState() => _DriverSettingPageState();
}

class _DriverSettingPageState extends State<DriverSettingPage> {
  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    await context.read<DriverProfileCubit>().fetchDriverProfile();
    await context.read<DriverVehiclesDocsCubit>().fetchDriverVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appWhiteColor,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.appBlackColor,
            size: 24,
          ),
        ),
        title: Text(
          "Settings",
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FutureBuilder(
            //   future: SecureStorage().getUserProfile(),
            //   builder: (context, AsyncSnapshot<ProfileModel?> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const CircularProgressIndicator();
            //     }

            //     final name = snapshot.data?.user.username ?? 'Guest';
            //     final email = 'Not available';

            //     return ProfileHeader(
            //       image: SvgImage.profile.value,
            //       title: name,
            //       subTitle: email,
            //       arrow: SvgImage.arrow.value,
            //       height: 64,
            //     );
            //   },
            // ),
            BlocBuilder<DriverProfileCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CommonStateSuccess<DriverSettingsModel>) {
                  final profile = state.data;
                  final name = profile.data?.username ?? "Guest";
                  final email = profile.data?.email ?? 'Not available';
                  final image = profile.data?.profileImage;
                  final vehicle = profile.data!.vehicleInfo;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeader(
                        image: image ?? "N",
                        title: name,
                        subTitle: email,
                        arrow: SvgImage.arrow.value,
                        height: 64,
                      ),
                      const SizedBox(height: 20),

                      if (vehicle != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ProfileHeader(
                            image: SvgImage.car.value,
                            title: vehicle.carName ?? " NO Car NAme",
                            subTitle: vehicle.vehicleNumber ?? " NO Car Number",
                            arrow: SvgImage.arrow.value,
                            height: 20,
                          ),
                        )
                      else
                        const Text("No vehicle information found."),
                    ],
                  );
                } else if (state is CommonError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }

                return const SizedBox(); // fallback
              },
            ),

            SizedBox(height: 20),
            HeadingTitle(),

            InkWell(
              onTap: () {
                Get.to(() => DriverVechiclesDocScreen());
              },
              child: Text('Driver Vehicles Doc Preview'),
            ),
            SizedBox(height: 15),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),

            //   decoration: BoxDecoration(
            //     border: Border.all(color: AppColors.appGrayColor),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: ProfileHeader(
            //     image: SvgImage.car.value,
            //     title: 'Toyota Camry',
            //     subTitle: 'ABC 123',
            //     arrow: SvgImage.arrow.value,
            //     height: 20,
            //   ),
            // ),
            // SizedBox(height: 18),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),

            //   decoration: BoxDecoration(
            //     border: Border.all(color: AppColors.appGrayColor),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: ProfileHeader(
            //     image: SvgImage.car.value,
            //     title: 'Ford F-150',
            //     subTitle: 'XYZ 789',
            //     arrow: SvgImage.arrow.value,
            //     height: 20,
            //   ),
            // ),
            SizedBox(height: 20),
            SettingsItem(
              iconPath: SvgImage.languages.value,
              title: "Language",
              trailingText: "English",
              onTap: () {},
            ),
            // SettingsItem(
            //   iconPath: SvgImage.languages.value,
            //   title: "Notifications",
            //   trailingText: "",
            //   onTap: () {},
            // ),
            SettingsItem(
              iconPath: SvgImage.darkModes.value,
              title: "Dark Mode",
              trailingText: "",
              onTap: () {},
              showArrow: false,
            ),
          ],
        ),
      ),
    );
  }
}
