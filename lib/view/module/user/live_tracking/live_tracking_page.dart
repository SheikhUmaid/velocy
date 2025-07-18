import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/socket/ride_tracking.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/user/live_tracking/component/ride_cancel_dailogs.dart';

import '../user_book_ride_page/map_page.dart';

class LiveTrackingPage extends StatefulWidget {
  const LiveTrackingPage({super.key});

  @override
  State<LiveTrackingPage> createState() => _LiveTrackingPageState();
}

class _LiveTrackingPageState extends State<LiveTrackingPage> {
  final RideTrackingService _rideTrackingService = RideTrackingService();
  Marker? _driverMarker;

  // final Completer<GoogleMapController> _mapController = Completer();
  late GoogleMapController _mapController;
  LatLng? _currentLocation;

  final LatLng _pickupLocation = LatLng(26.070879586062855, 83.01872973328766);
  final LatLng _dropLocation = LatLng(26.839972770972068, 80.93342481962424);

  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];
  final String _googleApiKey =
      "AIzaSyCMnUiAvEu6ytGmFvZXF4R0Do0j0ON6axY"; // 🔑 Replace this

  @override
  void initState() {
    super.initState();
    _rideTrackingService.connect(Get.arguments['rideId']);
    _rideTrackingService.locationStream.listen((location) {
      final position = LatLng(location['latitude']!, location['longitude']!);

      setState(() {
        _driverMarker = Marker(
          markerId: MarkerId("driver"),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
      });
      Future.microtask(() async {
        // final controller = await _mapController.future;
        _mapController.animateCamera(CameraUpdate.newLatLng(position));
      });
    });
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    // final controller = await _mapController.future;
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLocation!, 14),
    );

    _getPolylinePoints(); // 🚀 Fetch polyline path from API
  }

  Future<void> _getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      _googleApiKey,
      PointLatLng(_pickupLocation.latitude, _pickupLocation.longitude),
      PointLatLng(_dropLocation.latitude, _dropLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      _polylineCoordinates.clear();
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId("route"),
            width: 5,
            color: Colors.blue,
            points: _polylineCoordinates,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _rideTrackingService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Live Tracking", centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          children: [
            // CustomRouteMapView(
            //   pickup: _pickupLocation.toString(),
            //   drop: _dropLocation.toString(),
            //   stops: [],
            // ),
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
                zoom: 14,
              ),
              onMapCreated: (controller) => _mapController = controller,
              markers: _driverMarker != null ? {_driverMarker!} : {},
            ),
            const SizedBox(height: 18),
            // UI Part — Rider Details, Pickup, Drop, Buttons
            _rideDetailsSection(),
          ],
        ),
      ),
    );
  }

  Widget _rideDetailsSection() {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(SvgImage.profile.value, height: 65, width: 65),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("John Driver", style: AppTextStyle.small16SizeText),
                  const SizedBox(height: 4),
                  Text(
                    "KA 01 AB 1234",
                    style: AppTextStyle.small16SizeText.copyWith(
                      color: AppColors.appTextColors,
                    ),
                  ),
                  Text(
                    "Toyota Camry - Silver",
                    style: AppTextStyle.small14SizeText.copyWith(
                      color: AppColors.appTextColors,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _circleIcon(SvgImage.phone.value, () {}),
                const SizedBox(width: 10),
                _circleIcon(SvgImage.circleMessage.value, () {
                  Get.toNamed(Routes.riderChatPage.value);
                }),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18),
        _locationRow(SvgImage.round.value, "Pick-up", "123 Main Street"),
        const SizedBox(height: 18),
        _locationRow(SvgImage.locations.value, "Drop-off", "456 Park Avenue"),
        const SizedBox(height: 18),
        _actionButton(SvgImage.share.value, "Share Ride Details", () {
          Get.toNamed(Routes.driverArrivalScreen.value);
        }),
        const SizedBox(height: 18),
        _actionButton(SvgImage.rideCancel.value, "Cancel Ride", () {
          showCancelRideDialog(context);
        }, bgColor: const Color(0xFFE5E7EB)),
      ],
    );
  }

  Widget _circleIcon(String asset, VoidCallback onPressed) {
    return CircleAvatar(
      radius: 17,
      backgroundColor: Colors.grey.shade300,
      child: IconButton(icon: SvgPicture.asset(asset), onPressed: onPressed),
    );
  }

  Widget _locationRow(String icon, String title, String address) {
    return Row(
      children: [
        SvgPicture.asset(icon, height: 16, width: 16),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.small16SizeText),
              const SizedBox(height: 4),
              Text(address, style: AppTextStyle.small16SizeText),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionButton(
    String icon,
    String label,
    VoidCallback onTap, {
    Color bgColor = const Color(0xFFF5F5F5),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, height: 16, width: 14),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyle.small16SizeText.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
