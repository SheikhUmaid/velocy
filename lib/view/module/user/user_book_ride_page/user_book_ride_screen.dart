import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:velocy_user_app/helper/placemarkToAddress.dart';

import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/constants.dart';
import 'package:velocy_user_app/utils/shimmer_widget.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/cubit/live_offer_cubit.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/cubit/rider_profile_cubit.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/drawer_widget.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/models/get_live_offer_response_model.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/models/get_rider_profile_response_model.dart';
import 'package:velocy_user_app/widgets/my_textfield.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

import '../../../../service/local_storage/secure_storage.dart';
import '../../../auth_page/model/profile_model.dart';

class UserBookRideScreen extends StatefulWidget {
  const UserBookRideScreen({super.key});

  @override
  State<UserBookRideScreen> createState() => _UserBookRideScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _UserBookRideScreenState extends State<UserBookRideScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  Placemark? _currentAddress;
  final TextEditingController _searchController = TextEditingController();
  Marker? _marker;
  int? selectedFavoriteIndex;

  @override
  void initState() {
    super.initState();
    _refreshData();
    _fetchCurrentLocation();
  }

  Future<void> _refreshData() async {
    await context.read<LiveOfferCubit>().getLiveOffers();
    await context.read<RiderProfileCubit>().getRiderProfile();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Location Disabled", "Please enable location services.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text("Permission Required"),
                content: const Text(
                  "Location permission is permanently denied. Please enable it from app settings.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await Geolocator.openAppSettings();
                    },
                    child: const Text("Open Settings"),
                  ),
                ],
              ),
        );
        return;
      }

      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied", "Location permission is required.");
        return;
      }

      // ✅ Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      LatLng latLng = LatLng(position.latitude, position.longitude);

      // ✅ Reverse geocode to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = "Unknown Location";
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address =
            "${place.name}, ${place.locality}, ${place.administrativeArea}";
      }

      // ✅ Update state
      setState(() {
        _currentLocation = latLng;
        _currentAddress = placemarks.first;
        _marker = Marker(
          markerId: const MarkerId('current-location'),
          position: latLng,
          infoWindow: InfoWindow(title: "You are here"),
        );
      });

      // ✅ Animate camera to current location
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 15),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error fetching current location: $e");
      Get.snackbar("Location Error", "Failed to fetch current location.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserDrawer(),
      backgroundColor: AppColors.appBgColor,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildLocationInputBox(),
                  _buildGoogleMap(),
                  _buildLiveOffers(),
                  _buildFavorites(),
                  _buildRideTypes(),
                  _buildBookNowButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavorites() {
    final favorites = [
      {'icon': SvgImage.home.value, 'label': 'Home'},
      {'icon': SvgImage.office.value, 'label': 'Office'},
      {'icon': SvgImage.office.value, 'label': 'Office'},
      {'icon': SvgImage.airport.value, 'label': 'Airport'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Text(
            "Favourite",
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interMedium,
              color: AppColors.appBlackColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                favorites.asMap().entries.map((entry) {
                  int index = entry.key;
                  var fav = entry.value;
                  bool isSelected = selectedFavoriteIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFavoriteIndex = index;
                        // _searchController.text = fav['label']!; // optional: set selected address
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 59,
                          width: 62.93,
                          padding: const EdgeInsets.all(17.5),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.29),
                            color:
                                isSelected
                                    ? AppColors.appWhiteColor.withOpacity(0.2)
                                    : const Color(0xFFE8E8E8),
                            border:
                                isSelected
                                    ? Border.all(
                                      color: AppColors.appBlackColor,
                                      width: 1.5,
                                    )
                                    : null,
                          ),
                          child: SvgPicture.asset(fav['icon']!),
                        ),
                        Text(
                          fav['label']!,
                          style: AppTextStyle.small16SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                            color:
                                isSelected
                                    ? AppColors.appBlackColor
                                    : AppColors.appBlackColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return BlocBuilder<RiderProfileCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(SvgImage.profile.value),
                    const SizedBox(width: 22),
                    Text(
                      "Loading...",
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(SvgImage.notification.value),
              ],
            ),
          );
        } else if (state is CommonError) {
          return Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Center(
              child: Text(
                state.message ?? "Error loading profile",
                style: AppTextStyle.small14SizeText.copyWith(
                  color: AppColors.appRedColor,
                ),
              ),
            ),
          );
        } else if (state is CommonStateSuccess) {
          final riderProfile = state.data as GetRiderProfileResponseModel;
          String name = riderProfile.username ?? "User";

          return Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.appBlackColor.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
              border: Border(
                bottom: BorderSide(
                  color: AppColors.appBlackColor.withOpacity(0.05),
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: Image.network(
                        riderProfile.profile ?? '',
                        height: 32,
                        width: 32,
                        errorBuilder: (context, _, __) {
                          return SvgPicture.asset(
                            SvgImage.profile.value,
                            height: 32,
                            width: 32,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 22),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, $name",
                          style: AppTextStyle.small14SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                        Text(
                          "Welcome back",
                          style: AppTextStyle.small12SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                            color: AppColors.appDarkGrayColor73,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.notificationPage.value);
                  },
                  child: SvgPicture.asset(SvgImage.notification.value),
                ),
              ],
            ),
          );
        }
        return Container(); // Fallback if no state matches
      },
    );
  }

  Widget _buildLocationInputBox() {
    return Container(
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.appWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.appBlackColor.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                SvgImage.location.value,
                color: const Color(0xff525252),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Location",
                      style: AppTextStyle.small12SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: const Color(0xFF737373),
                      ),
                    ),
                    Text(
                      placemarkToAddressString(
                        _currentAddress,
                        defaultValue: "Fetching address...",
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.small14SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          GooglePlaceAutoCompleteTextField(
            textEditingController: _searchController,
            googleAPIKey:
                "AIzaSyCMnUiAvEu6ytGmFvZXF4R0Do0j0ON6axY", // Replace with your real key
            inputDecoration: InputDecoration(
              hintText: "Where to?",
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xffA3A3A3),
                size: 22,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: SvgPicture.asset(SvgImage.mic.value),
              ),
              border: InputBorder.none,
            ),
            debounceTime: 800,
            countries: const ["in"], // Limit to India (optional)
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) async {
              final lat = double.tryParse(prediction.lat ?? "") ?? 0;
              final lng = double.tryParse(prediction.lng ?? "") ?? 0;

              setState(() {
                _currentLocation = LatLng(lat, lng);
                _mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(target: _currentLocation!, zoom: 15),
                  ),
                );
              });

              try {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  lat,
                  lng,
                );
                if (placemarks.isNotEmpty) {
                  final place = placemarks.first;
                  setState(() {
                    _currentAddress = place;
                  });
                }
              } catch (e) {
                debugPrint("Reverse geocoding failed: $e");
              }
            },
            itemClick: (Prediction prediction) {
              _searchController.text = prediction.description ?? "";
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleMap() {
    if (_currentLocation == null) {
      return ShimmerMapPlaceholder(
        height: MediaQuery.of(context).size.height * 0.4,
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentLocation!,
            zoom: 14.0,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;
          },
          onTap: (LatLng tappedPoint) async {
            setState(() {
              _currentLocation = tappedPoint;
            });

            // Reverse geocode the tapped location
            try {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                tappedPoint.latitude,
                tappedPoint.longitude,
              );

              if (placemarks.isNotEmpty) {
                final place = placemarks.first;
                final address =
                    "${place.name}, ${place.locality}, ${place.administrativeArea}";

                setState(() {
                  _searchController.text = address;
                  _marker = Marker(
                    markerId: const MarkerId('selected-location'),
                    position: tappedPoint,
                    infoWindow: InfoWindow(title: 'Selected Location'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
                  );
                });
              }
            } catch (e) {
              debugPrint("Error in reverse geocoding: $e");
            }
          },
          markers: _marker != null ? {_marker!} : {},
        ),
      ),
    );
  }

  Widget _buildLiveOffers() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Live Offers",
                style: AppTextStyle.small16SizeText.copyWith(
                  color: AppColors.appBlackColor,
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
        ),

        BlocBuilder<LiveOfferCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoading) {
              return Container(
                height: 40,
                width: 40,
                // margin: const EdgeInsets.symmetric(vertical: 4),
                // padding: const EdgeInsets.symmetric(
                //   horizontal: 16,
                //   vertical: 18,
                // ),
                color: AppColors.appWhiteColor,
                child: CircularProgressIndicator(),
              );
            } else if (state is CommonError) {
              return SizedBox(
                height: 76,
                child: Center(
                  child: Text(
                    state.message ?? "Failed to load offers",
                    style: AppTextStyle.small14SizeText.copyWith(
                      color: AppColors.appRedColor,
                    ),
                  ),
                ),
              );
            } else if (state is CommonStateSuccess) {
              final liveOffersResponse =
                  state.data as GetLiveOfferResponseModel;
              final liveOffers = liveOffersResponse.liveOffers ?? [];
              if (liveOffers.isNotEmpty) {
                return SizedBox(
                  height: 76,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 14),
                    itemCount: liveOffers.length,
                    itemBuilder: (context, index) {
                      String offerText =
                          liveOffers[index].description ??
                          "No live offers available";
                      String promoCode =
                          liveOffers[index].code ??
                          ''; // Replace with dynamic data if needed

                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 14),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.appBlackColor2626,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offerText,
                              style: AppTextStyle.small14SizeText.copyWith(
                                color: AppColors.appWhiteColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: promoCode),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Code '$promoCode' copied to clipboard!",
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Use code: $promoCode",
                                      style: AppTextStyle.small12SizeText
                                          .copyWith(
                                            color: AppColors.appWhiteColor,
                                          ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildRideTypes() {
    final types = [
      {'icon': SvgImage.shaduled.value, 'label': 'Scheduled'},
      {'icon': SvgImage.pool.value, 'label': 'Pool'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children:
            types.map((type) {
              return Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (type['label'] == "Scheduled") {
                      await Get.toNamed(
                        Routes.bookRideScreen.value,
                        arguments: {
                          'currentAddress': _currentAddress,
                          'selectedAddress': _searchController.text,
                          'from': "Scheduled",
                        },
                      );
                    } else {}
                    print('Tapped on ${type['label']}');
                    // You can trigger state updates, navigation, etc.
                  },
                  child: Container(
                    height: 84,
                    margin: const EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      color: AppColors.appWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withOpacity(0.05),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(type['icon']!),
                        const SizedBox(height: 8),
                        Text(
                          type['label']!,
                          style: AppTextStyle.small14SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildBookNowButton() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: PrimaryButton(
        onPressed: () async {
          await Get.toNamed(
            Routes.bookRideScreen.value,
            arguments: {
              'currentAddress': _currentAddress,
              'selectedAddress': _searchController.text,
              'from': "now",
            },
          );
        },
        text: "Book now",
        height: 52,
        borderRadius: 12,
        style: AppTextStyle.small14SizeText.copyWith(
          color: AppColors.appWhiteColor,
          fontFamily: FontFamily.interRegular,
        ),
      ),
    );
  }
}
