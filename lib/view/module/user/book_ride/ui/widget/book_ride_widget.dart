import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/placemarkToAddress.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/add_ride_stops_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/confirm_location_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/add_ride_stops_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/confirm_location_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/response/confirm_location_response_model.dart';

class BookRideWidget extends StatefulWidget {
  const BookRideWidget({Key? key}) : super(key: key);

  @override
  State<BookRideWidget> createState() => _BookRideWidgetState();
}

class _BookRideWidgetState extends State<BookRideWidget> {
  Placemark? pickupAddress;
  String? dropAddress;
  String? from;
  List<String?> stopLocations = [];

  Future<void> selectLocation(bool isPickup, {int? stopIndex}) async {
    final result = await Get.toNamed(Routes.selectLocationPage.value);
    if (result != null && result is Map) {
      final address = result['placemark'] as Placemark;
      setState(() {
        if (isPickup) {
          pickupAddress = address;
        } else if (stopIndex != null) {
          stopLocations[stopIndex] = placemarkToAddressString(address);
        } else {
          dropAddress = placemarkToAddressString(address);
        }
      });
      print("Pickup: $pickupAddress, Drop: $dropAddress, From: $from");
    }
  }

  Widget _buildStopField(int index) {
    return GestureDetector(
      onTap: () => selectLocation(false, stopIndex: index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            SvgPicture.asset(SvgImage.location.value, height: 21),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                stopLocations[index] ?? 'Stop ${index + 1}',
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color:
                      stopLocations[index] == null ? Colors.grey : Colors.black,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: () {
                setState(() {
                  stopLocations.removeAt(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Accessing passed arguments from previous screen
    final args = Get.arguments;

    if (args != null && args is Map) {
      setState(() {
        pickupAddress = args['currentAddress'];
        dropAddress = args['selectedAddress'];
        from = args['from'];
      });
      print("Pickup: $pickupAddress, Drop: $dropAddress, From: $from");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Book a Ride"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(SvgImage.round.value, height: 12),
                          Container(
                            width: 1,
                            height: 50,
                            color: Colors.grey.shade400,
                          ),
                          SvgPicture.asset(SvgImage.round.value, height: 12),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: [
                            TextField(
                              onTap: () => selectLocation(true),
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:
                                    placemarkToAddressString(pickupAddress) ??
                                    'Pickup location',
                                hintStyle: TextStyle(
                                  fontFamily: FontFamily.interRegular,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              onTap: () => selectLocation(false),
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: dropAddress ?? 'Drop location',
                                hintStyle: TextStyle(
                                  fontFamily: FontFamily.interRegular,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (stopLocations.length < 5) {
                          stopLocations.add(null);
                        } else {
                          Get.snackbar(
                            'Limit reached',
                            'You can only add up to 5 stops.',
                          );
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          'Add stop',
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < stopLocations.length; i++) ...[
                      _buildStopField(i),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
            BlocListener<ConfirmLocationCubit, CommonState>(
              listener: (context, state) async {
                if (state is CommonError) {
                  Get.snackbar('Error', state.message ?? 'An error occurred');
                } else if (state is CommonStateSuccess) {
                  if (stopLocations != []) {
                    for (String? i in stopLocations) {
                      if (i != null) {
                        final stopLocation = await locationFromAddress(i);
                        await context.read<AddRideStopsCubit>().addRideStop(
                          addRideStopsRequestModel: AddRideStopsRequestModel(
                            ride:
                                (state.data as ConfirmLocationResponseModel)
                                    .id ??
                                '',
                            latitude: stopLocation.first.latitude
                                .toStringAsFixed(6),
                            longitude: stopLocation.first.longitude
                                .toStringAsFixed(6),
                            location: i,
                          ),
                        );
                      }
                    }
                  }

                  Get.toNamed(
                    Routes.confirmBookRide.value,
                    arguments: {
                      'pickup': pickupAddress,
                      'drop': dropAddress,
                      'stops': stopLocations,
                      'from': from,
                      'rideId': (state.data as ConfirmLocationResponseModel).id,
                    }..removeWhere((key, value) => value == null),
                  );
                }
              },
              child: BlocBuilder<ConfirmLocationCubit, CommonState>(
                builder: (context, state) {
                  return PrimaryButton(
                    radius: 8,
                    height: 48,
                    widget:
                        state is CommonLoading
                            ? const CustomCupertinoIndicator()
                            : null,
                    onPressed: () async {
                      if (pickupAddress != null && dropAddress != null) {
                        // final stops = stopLocations.whereType<String>().toList();
                        debugPrint(
                          "Pickup: $pickupAddress, Drop: $dropAddress, From: $from",
                        );

                        final pickupLocation = await locationFromAddress(
                          placemarkToAddressString(pickupAddress),
                        );

                        final dropLocation = await locationFromAddress(
                          dropAddress ?? '',
                        );

                        await context
                            .read<ConfirmLocationCubit>()
                            .confirmLocation(
                              confirmLocationRequestModel:
                                  ConfirmLocationRequestModel(
                                    rideType: from,
                                    cityName: "Bangalore",
                                    fromLocation: placemarkToAddressString(
                                      pickupAddress,
                                    ),
                                    fromLatitude: pickupLocation.first.latitude
                                        .toStringAsFixed(6),
                                    fromLongitude: pickupLocation
                                        .first
                                        .longitude
                                        .toStringAsFixed(6),
                                    toLocation: dropAddress,
                                    toLatitude: dropLocation.first.latitude
                                        .toStringAsFixed(6),
                                    toLongitude: dropLocation.first.longitude
                                        .toStringAsFixed(6),
                                    distanceKm: (Geolocator.distanceBetween(
                                              pickupLocation.first.latitude,
                                              pickupLocation.first.longitude,
                                              dropLocation.first.latitude,
                                              dropLocation.first.longitude,
                                            ) /
                                            1000)
                                        .toStringAsFixed(2),

                                    // TODO: Add ride purpose if needed
                                    // ridePurpose: "Normal",
                                  ),
                            );

                        // Get.toNamed(
                        //   Routes.confirmBookRide.value,
                        //   arguments: {
                        //     'pickup': pickupAddress,
                        //     'drop': dropAddress,
                        //     'stops': stopLocations.whereType<String>().toList(),
                        //     'from': from,
                        //   },
                        // );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Please select both pickup and drop locations',
                        );
                      }
                    },
                    title: "Confirm Location",
                    textSize: 20,
                    color: AppColors.appBlackColor,
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
