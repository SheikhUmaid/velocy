import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:velocy_user_app/helper/placemarkToAddress.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/utils/textfield.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/estimate_price_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/ride_booking_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/vehicle_types_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/estimate_price_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/request/ride_booking_request_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/response/estimate_price_response_model.dart';
import 'package:velocy_user_app/view/module/user/book_ride/models/response/vehicle_types_response_model.dart';

import '../../../user_book_ride_page/map_page.dart';
import '../widgets/date_time_picker_row.dart';

class ConfirmRidePage extends StatefulWidget {
  const ConfirmRidePage({super.key});

  @override
  State<ConfirmRidePage> createState() => _ConfirmRidePageState();
}

class _ConfirmRidePageState extends State<ConfirmRidePage> {
  final Completer<GoogleMapController> _mapController = Completer();
  LatLng? pickupLatLng;
  LatLng? dropoffLatLng;
  List<String> stopAddresses = [];
  List<String> allAddresses = [];
  List<LatLng> stopCoordinates = [];
  Set<Polyline> _polylines = {};

  double _distanceInKm = 0.0;
  final TextEditingController _priceController = TextEditingController();

  int? selectedVehicleIndex;
  bool womenOnly = false;
  String? from;
  final List<String> vehicleImages = [
    'assets/app_images/bike_vector.png',
    'assets/app_images/car_vector.png',
    'assets/app_images/cab_vector.png',
  ];

  final String googleAPIKey =
      'AIzaSyCMnUiAvEu6ytGmFvZXF4R0Do0j0ON6axY'; // Replace with real key

  @override
  void initState() {
    final args = Get.arguments;
    from = args['from'];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeLocations());
  }

  Future<void> _initializeLocations() async {
    final args = Get.arguments;
    final Placemark pickup = args['pickup'];
    final String drop = args['drop'];
    final List<String> stops = List<String>.from(args['stops'] ?? []);
    allAddresses = [placemarkToAddressString(pickup), ...stops, drop];
    stopAddresses = stops;
    debugPrint("Pickup initialization: $pickup, Drop: $drop, Stops: $stops");
    debugPrint("All addresses: $allAddresses, Stop addresses: $stopAddresses");
    try {
      final pickupLocations = await locationFromAddress(
        placemarkToAddressString(pickup),
      );
      final dropLocations = await locationFromAddress(drop);

      debugPrint(
        "Pickup locations: $pickupLocations, Drop locations: $dropLocations",
      );

      final tempStopCoords = <LatLng>[];
      for (String stop in stops) {
        final locations = await locationFromAddress(stop);
        if (locations.isNotEmpty) {
          tempStopCoords.add(
            LatLng(locations.first.latitude, locations.first.longitude),
          );
        }
      }

      setState(() {
        pickupLatLng = LatLng(
          pickupLocations.first.latitude,
          pickupLocations.first.longitude,
        );
        dropoffLatLng = LatLng(
          dropLocations.first.latitude,
          dropLocations.first.longitude,
        );
        stopCoordinates = tempStopCoords;
        _polylines.clear();
      });

      debugPrint(
        "Pickup LatLng: $pickupLatLng, Dropoff LatLng: $dropoffLatLng, Stops: $stopCoordinates",
      );

      await _drawRoutePolyline();
      await _moveCameraToBounds();
    } catch (e) {
      print("Geocoding error: $e");
      Get.snackbar("Error", "Unable to fetch location coordinates");
    }
  }

  Future<void> _drawRoutePolyline() async {
    final points = [pickupLatLng!, ...stopCoordinates, dropoffLatLng!];

    for (int i = 0; i < points.length - 1; i++) {
      final origin = points[i];
      final destination = points[i + 1];
      final url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$googleAPIKey';

      try {
        final response = await http.get(Uri.parse(url));
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final polylinePoints =
              data['routes'][0]['overview_polyline']['points'];
          final List<LatLng> decodedPoints = _decodePolyline(polylinePoints);

          final polyline = Polyline(
            polylineId: PolylineId('route_$i'),
            color: Colors.blue,
            width: 5,
            points: decodedPoints,
          );

          setState(() => _polylines.add(polyline));
        } else {
          print('Directions API error: ${data['status']}');
        }
      } catch (e) {
        print("Polyline decoding error: $e");
      }
    }
  }

  Future<void> _moveCameraToBounds() async {
    final controller = await _mapController.future;
    final allPoints = [pickupLatLng!, ...stopCoordinates, dropoffLatLng!];

    final southwestLat = allPoints
        .map((e) => e.latitude)
        .reduce((a, b) => a < b ? a : b);
    final southwestLng = allPoints
        .map((e) => e.longitude)
        .reduce((a, b) => a < b ? a : b);
    final northeastLat = allPoints
        .map((e) => e.latitude)
        .reduce((a, b) => a > b ? a : b);
    final northeastLng = allPoints
        .map((e) => e.longitude)
        .reduce((a, b) => a > b ? a : b);

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(southwestLat, southwestLng),
          northeast: LatLng(northeastLat, northeastLng),
        ),
        50,
      ),
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Book a Ride",
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: _initializeLocations,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomRouteMapView(
              pickup: placemarkToAddressString(Get.arguments['pickup']),
              drop: Get.arguments['drop'] ?? '',
              // stops: Get.arguments['stops'] ?? [],
              // pickup: allAddresses.isNotEmpty ? allAddresses.first : '',
              // drop: allAddresses.length > 1 ? allAddresses.last : '',
              stops: stopAddresses,
            ),
            const SizedBox(height: 16),
            _buildLocationInfo(),
            const SizedBox(height: 16),
            if (from == "Scheduled") DateTimePickerRow(),
            if (from == "Scheduled") const SizedBox(height: 16),
            _buildVehicleSelector(),
            const SizedBox(height: 12),
            _buildPriceInput(),
            const SizedBox(height: 12),
            _buildWomenOnlyOption(),
            const SizedBox(height: 19),
            BlocListener<RideBookingCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonError) {
                  Get.snackbar("Error", state.message);
                } else if (state is CommonStateSuccess) {
                  Get.toNamed(Routes.driverWatingPage.value);
                }
              },
              child: BlocBuilder<RideBookingCubit, CommonState>(
                builder: (context, state) {
                  return PrimaryButton(
                    widget:
                        state is CommonLoading
                            ? const CustomCupertinoIndicator()
                            : null,
                    onPressed: () async {
                      await context.read<RideBookingCubit>().rideBooking(
                        rideBookingRequestModel: RideBookingRequestModel(
                          rideId: Get.arguments['rideId'],
                          womenOnly: womenOnly,
                          offeredPrice: _priceController.text,
                        ),
                      );
                      // if (state is CommonError) {
                      //   Get.snackbar("Error", state.message);
                      //   return;
                      // }
                      // if (state is CommonStateSuccess) {
                      //   Get.toNamed(Routes.driverWatingPage.value);
                      // }
                    },
                    title: "Request Ride",
                    height: 56,
                    radius: 8,
                    color: AppColors.appBlackColor,
                  );
                },
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget _buildMapView() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child:
            pickupLatLng == null || dropoffLatLng == null
                ? const Center(
                  child: Text(
                    "Loading map...",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: pickupLatLng!,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('pickup'),
                      position: pickupLatLng!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue,
                      ),
                      infoWindow: const InfoWindow(title: "Pickup Spot"),
                    ),
                    Marker(
                      markerId: const MarkerId('dropoff'),
                      position: dropoffLatLng!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed,
                      ),
                      infoWindow: const InfoWindow(title: "Destination"),
                    ),
                    ...List.generate(stopCoordinates.length, (index) {
                      return Marker(
                        markerId: MarkerId('stop$index'),
                        position: stopCoordinates[index],
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueOrange,
                        ),
                        infoWindow: InfoWindow(title: 'Stop ${index + 1}'),
                      );
                    }),
                  },
                  polylines: _polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  onMapCreated: (controller) {
                    if (!_mapController.isCompleted) {
                      _mapController.complete(controller);
                    }
                  },
                ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    final displayAddresses = [
      if (allAddresses.isNotEmpty) allAddresses.first,
      ...stopAddresses,
      if (allAddresses.length > 1) allAddresses.last,
    ];

    return Column(
      children: List.generate(displayAddresses.length, (index) {
        bool isStop = index > 0 && index < displayAddresses.length - 1;
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  isStop ? SvgImage.dot.value : SvgImage.round.value,
                  height: 16,
                ),
                const SizedBox(width: 12),
                Expanded(child: _buildReadOnlyField(displayAddresses[index])),
              ],
            ),
            if (index < displayAddresses.length - 1)
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 1,
                    height: 24,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(width: 12),
                  const SizedBox(height: 24),
                ],
              ),
          ],
        );
      }),
    );
  }

  Widget _buildReadOnlyField(String hint) => TextField(
    readOnly: true,
    decoration: InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.boxColors),
      ),
    ),
  );

  Widget _buildVehicleSelector() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.boxColors,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose Vehicle Type", style: AppTextStyle.small16SizeText),
        const SizedBox(height: 12),
        BlocBuilder<VehicleTypesCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommonError) {
              return Center(child: Text(state.message));
            } else if (state is CommonStateSuccess) {
              final response = state.data as VehicleTypesResponseModel;
              final vehicleTypes = response.vehicleTypes;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(vehicleTypes.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedVehicleIndex = index);
                      context.read<EstimatePriceCubit>().estimatePrice(
                        estimatePriceRequestModel: EstimatePriceRequestModel(
                          rideId: Get.arguments['rideId'],
                          vehicleType: vehicleTypes[index].id.toString(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              selectedVehicleIndex == index
                                  ? Colors.black
                                  : AppColors.appWhiteColor,
                          width: 2,
                        ),
                      ),
                      child: Image.network(
                        vehicleTypes[index].image,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Icon(Icons.image, color: Colors.red),
                        width: 60,
                        height: 60,
                      ),
                    ),
                  );
                }),
              );
            }
            return const Center(child: Text("No vehicle types available"));
          },
        ),
        const SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.appWhiteColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Text(
                "Estimate Price :",
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
              BlocBuilder<EstimatePriceCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonLoading) {
                    return Text(
                      " ₹0",
                      style: AppTextStyle.medium18SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: Colors.red,
                      ),
                    );
                  } else if (state is CommonError) {
                    return Text(
                      " ₹0",
                      style: AppTextStyle.medium18SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: Colors.red,
                      ),
                    );
                  } else if (state is CommonStateSuccess) {
                    return Text(
                      " ₹${(state.data as EstimatePriceResponseModel).estimatePrice.estimatedPrice}",
                      style: AppTextStyle.medium18SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    );
                  } else {
                    return Text(
                      " ₹0",
                      style: AppTextStyle.medium18SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );

  Widget _buildPriceInput() => Row(
    children: [
      Expanded(
        child: PrimaryTextField(
          controller: _priceController,
          fillColor: AppColors.boxColors,
          hintText: "Enter Price",
        ),
      ),
      const SizedBox(width: 8),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          backgroundColor: Colors.grey[900],
        ),
        child: const Text("Ok"),
      ),
    ],
  );

  Widget _buildWomenOnlyOption() => Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    decoration: BoxDecoration(
      color: AppColors.boxColors,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Checkbox(
          value: womenOnly,
          onChanged: (value) => setState(() => womenOnly = value!),
        ),
        const Text("Women only"),
        const Spacer(),
        SvgPicture.asset(SvgImage.time.value),
      ],
    ),
  );
}
