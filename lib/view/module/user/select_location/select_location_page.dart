import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:velocy_user_app/helper/placemarkToAddress.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  GoogleMapController? _mapController;
  LatLng? _selectedLatLng;
  Placemark? _selectedAddress;
  LatLng? _initialCameraPosition; // Nullable to wait for GPS

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location Disabled", "Please enable location services.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Get.snackbar("Permission Denied", "Location permission is required.");
        return;
      }
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _initialCameraPosition = LatLng(position.latitude, position.longitude);
      _selectedLatLng = _initialCameraPosition; // Optional: pre-select
    });
    _getAddressFromLatLng(_initialCameraPosition!);
  }

  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _selectedAddress = place;
        });
      }
    } catch (e) {
      print("Address Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Select Location"),
      body:
          _initialCameraPosition == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialCameraPosition!,
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                      onTap: (LatLng latLng) {
                        setState(() {
                          _selectedLatLng = latLng;
                        });
                        _getAddressFromLatLng(latLng);
                      },
                      markers:
                          _selectedLatLng != null
                              ? {
                                Marker(
                                  markerId: const MarkerId("selected-location"),
                                  position: _selectedLatLng!,
                                ),
                              }
                              : {},
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),
                  if (_selectedAddress != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Text(
                        placemarkToAddressString(_selectedAddress),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: PrimaryButton(
                      onPressed: () {
                        if (_selectedLatLng != null) {
                          Get.back(
                            result: {
                              'latLng': _selectedLatLng,
                              'placemark': _selectedAddress,
                            },
                          );
                        } else {
                          Get.snackbar(
                            "Location Not Selected",
                            "Please tap on the map to select a location.",
                          );
                        }
                      },
                      radius: 8,
                      color: AppColors.appBlackColor,
                      title: "Confirm Location",
                      height: 56,
                    ),
                  ),
                ],
              ),
    );
  }
}
