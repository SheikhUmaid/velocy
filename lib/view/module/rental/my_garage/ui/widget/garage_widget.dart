import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/rental/cubit/my_garage_cubit.dart';
import 'package:velocy_user_app/view/module/rental/models/response/my_garage_response_model.dart';

class GarageWidget extends StatelessWidget {
  GarageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Rented Vehicle", centerTitle: true),
      body: Column(
        children: [
          BlocBuilder<MyGarageCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CommonError) {
                return Center(child: Text(state.message));
              } else if (state is CommonStateSuccess) {
                debugPrint(
                  "==========>GarageWidget: state data: ${state.data}",
                );
                final response = state.data as MyGarageResponseModel;
                final garageData = response.data;
                debugPrint("==========>GarageWidget: garageData: $garageData");
                if (garageData != []) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: garageData.length,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    itemBuilder: (context, index) {
                      final vehicle = garageData[index];
                      return _vehicleCard(vehicle);
                    },
                  );
                }
              }
              return SizedBox.shrink();
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButton(
              height: 50,
              onPressed: () {
                Get.toNamed(Routes.vechileAddPage.value);
              },
              title: "Add Vehicle",
              color: AppColors.appBlackColor,
              radius: 8,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _vehicleCard(MyGarageData vehicle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  vehicle.images?.first ?? "",
                  errorBuilder:
                      (context, error, stackTrace) => Image.asset(
                        AppImage.onBoarding.value,
                        height: 63,
                        width: 63,
                        fit: BoxFit.cover,
                      ),
                  height: 63,
                  width: 63,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Vehicle Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.vehicleName ?? "Unknown Vehicle",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        // color: AppColors.appBgColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vehicle.registrationNumber ?? "Unknown Plate",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appTextColors,
                      ),
                    ),
                    Text(
                      vehicle.vehicleColor ?? "Unknown Color",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appTextColors,
                      ),
                    ),
                  ],
                ),
              ),

              SvgPicture.asset(
                SvgImage.dot.value,
                height: 50,
                color: AppColors.appBorderGrayColor,
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade300,
                  ),
                  child: Center(
                    child: Text(
                      "Unavailable",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appBlackColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "Available",
                      style: AppTextStyle.small16SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appBgColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
