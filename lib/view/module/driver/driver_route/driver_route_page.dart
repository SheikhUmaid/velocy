import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';
class DriverRoutePage extends StatefulWidget {
  const DriverRoutePage({super.key});

  @override
  State<DriverRoutePage> createState() => _DriverRoutePageState();
}

class _DriverRoutePageState extends State<DriverRoutePage> {
  BitmapDescriptor? _pickupIcon;
  BitmapDescriptor? _dropoffIcon;

  final LatLng pickupLatLng = const LatLng(32.779167, -96.808891);
  final LatLng dropoffLatLng = const LatLng(32.78125, -96.799722);

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
  }

  Future<void> _loadCustomMarkers() async {
    final pickup = await _getResizedMarker('assets/app_images/bike.png', 64);
    final dropoff = await _getResizedMarker('assets/app_images/bike.png', 75);

    setState(() {
      _pickupIcon = pickup;
      _dropoffIcon = dropoff;
    });
  }


  Future<BitmapDescriptor> _getResizedMarker(String assetPath, int width) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? resized = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(resized!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "En Route",
        centerTitle: true,
        actions: [SvgPicture.asset(SvgImage.dot.value)],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 350,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _pickupIcon == null || _dropoffIcon == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: pickupLatLng,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('pickup'),
                    position: pickupLatLng,
                    icon: _pickupIcon!,
                    infoWindow: const InfoWindow(title: "Pickup Spot"),
                  ),
                  Marker(
                    markerId: const MarkerId('dropoff'),
                    position: dropoffLatLng,
                    icon: _dropoffIcon!,
                    infoWindow: const InfoWindow(title: "Destination"),
                  ),
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: [pickupLatLng, dropoffLatLng],
                    color: Colors.black,
                    width: 5,
                  ),
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
            ),
          ),

          // The rest of your UI remains unchanged
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.rideComplete.value);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Driver info
                    Row(
                      children: [
                        SvgPicture.asset(SvgImage.profile.value, height: 65),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Michael Smith",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                            Text(
                              "⭐ 4.89 (2.8k trips)",
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: AppColors.appTextColors,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Car info
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgImage.car.value, height: 14),
                          const SizedBox(width: 8),
                          Text(
                            "Toyota Camry • ABC 123",
                            style: AppTextStyle.small14SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Black",
                            style: AppTextStyle.small14SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                              color: AppColors.appTextColors,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Route points
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(SvgImage.round.value, height: 10),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Location",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appTextColors,
                                  ),
                                ),
                                Text(
                                  "123 Main Street",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appTextColors,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SvgPicture.asset(SvgImage.upArrow.value, height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(SvgImage.round.value, height: 10),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Destination",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appTextColors,
                                  ),
                                ),
                                Text(
                                  "456 Oak Avenue",
                                  style: AppTextStyle.small14SizeText.copyWith(
                                    fontFamily: FontFamily.interRegular,
                                    color: AppColors.appTextColors,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // SOS Button
                    Center(
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.warning, color: Colors.white),
                          label: Text(
                            "SOS",
                            style: AppTextStyle.small16SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                              color: AppColors.appBgColor,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Bottom time info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Estimated arrival",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: AppColors.appTextColors,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "12:45 PM",
                              style: AppTextStyle.medium18SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Time remaining",
                              style: AppTextStyle.small14SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: AppColors.appTextColors,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "15 min",
                              style: AppTextStyle.medium18SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
