import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/ui/page/testing_live_driver_cab_page.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/cubit/driver_vehicles_doc_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/model/driver_vechiles_doc_model.dart';

class DriverVechiclesDocScreen extends StatelessWidget {
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
          "Vehicles Information",
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ),
      body: BlocBuilder<DriverVehiclesDocsCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommonStateSuccess) {
            final data = state.data as DriverVehiclesDocModel;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "License Plate: ${data.data?.licensePlateNumber}",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Verified: ${data.data?.verified}",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Documents:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "${data.data?.driverLicense}",
                        height: 100,
                        width: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "${data.data?.vehicleRegistrationDoc}",
                        height: 100,
                        width: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "${data.data?.vehicleInsurance}",
                        height: 100,
                        width: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //Test live button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => TestLiveTrackingPage(
                                rideId: "39",
                                passengerName: 'John Doe',
                                destinationAddress: '123 Main St, City',
                              ),
                        ),
                      );
                    },
                    child: Text("Live Track"),
                  ),
                ],
              ),
            );
          } else if (state is CommonError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
