import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:dio/dio.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/local_storage/secure_storage.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/profile_screen.dart';
import 'package:velocy_user_app/view/module/rental/ui/widget/rental_box_widget.dart';

class RentalWidget extends StatefulWidget {
  const RentalWidget({super.key});

  @override
  State<RentalWidget> createState() => _RentalWidgetState();
}

class _RentalWidgetState extends State<RentalWidget> {
  final Dio _dio = Dio();
  List<Map<String, dynamic>> vehicles = [];
  bool isLoading = true;
  String selectedCategory = "All";
  final List<String> categories = [
    "All",
    "SUV",
    "Sedan",
    "Hatchback",
    "Multi Utility Vehicle",
  ];

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    try {
      setState(() {
        isLoading = true;
      });
      final accessToken = await SecureStorage().getAccessToken();
      // Replace with your actual server URL
      final response = await _dio.get(
        'http://82.25.104.152/rent/car-rental-home-screen/',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> vehicleList = response.data as List<dynamic>;

        setState(() {
          vehicles =
              vehicleList.map((vehicle) {
                return {
                  "id": vehicle['id'],
                  "title": _getVehicleTitle(vehicle['vehicle_type']),
                  "subtitle": vehicle['vehicle_name'],
                  "image":
                      vehicle['images'] != null && vehicle['images'].isNotEmpty
                          ? vehicle['images'][0]
                          : "assets/car2.jpg", // fallback image
                  "seats": vehicle['seating_capacity'],
                  "bags": _getBagCount(
                    vehicle['vehicle_type'],
                  ), // Estimate based on type
                  "price": "\$${vehicle['rental_price_per_hour']}",
                  "isAvailable": vehicle['is_available'],
                  "vehicle_type": vehicle['vehicle_type'],
                  "images": vehicle['images'] ?? [],
                };
              }).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching vehicles: $e');
      setState(() {
        isLoading = false;
      });
      // Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load vehicles: $e')));
    }
  }

  String _getVehicleTitle(String vehicleType) {
    switch (vehicleType.toLowerCase()) {
      case 'sedan':
        return 'Luxury Sedan';
      case 'suv':
        return 'Premium SUV';
      case 'hatchback':
        return 'Compact Hatchback';
      case 'multi utility vehicle':
        return 'Multi Utility Vehicle';
      default:
        return 'Vehicle';
    }
  }

  int _getBagCount(String vehicleType) {
    switch (vehicleType.toLowerCase()) {
      case 'sedan':
        return 2;
      case 'suv':
        return 4;
      case 'hatchback':
        return 2;
      case 'multi utility vehicle':
        return 3;
      default:
        return 2;
    }
  }

  List<Map<String, dynamic>> getFilteredVehicles() {
    if (selectedCategory == "All") {
      return vehicles;
    }
    return vehicles
        .where(
          (vehicle) =>
              vehicle['vehicle_type'].toLowerCase() ==
              selectedCategory.toLowerCase(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: false,
        title: "Select Vehicle",
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.asset(SvgImage.time2.value, height: 20),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RentalBoxWidget(
                  title: 'Sent Requests',
                  onPress: () {
                    Get.toNamed(Routes.rentRequest.value);
                  },
                ),
                RentalBoxWidget(
                  title: 'Received Requests',
                  onPress: () {
                    Get.toNamed(Routes.rentalVehicleProfile.value);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            RentalBoxWidget(
              title: 'My Garage',
              icons: SvgImage.logout.value,
              onPress: () {
                Get.toNamed(Routes.myGarage.value);
              },
            ),
            SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: categories.map((cat) => _categoryChip(cat)).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Vehicle Cards
            Expanded(
              child:
                  isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.appBlackColor,
                        ),
                      )
                      : getFilteredVehicles().isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.car_rental,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No vehicles available',
                              style: AppTextStyle.medium18SizeText.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                      : RefreshIndicator(
                        onRefresh: fetchVehicles,
                        child: ListView.builder(
                          itemCount: getFilteredVehicles().length,
                          itemBuilder: (context, index) {
                            final vehicle = getFilteredVehicles()[index];
                            return _vehicleCard(vehicle);
                          },
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryChip(String title) {
    final isSelected = title == selectedCategory;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          title,
          style: AppTextStyle.small14SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            color: isSelected ? AppColors.appBgColor : AppColors.appBlackColor,
          ),
        ),
      ),
    );
  }

  Widget _vehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                vehicle["title"],
                style: AppTextStyle.medium18SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color:
                      vehicle["isAvailable"]
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                ),
                child: Text(
                  vehicle["isAvailable"] ? "Available" : "Not Available",
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            vehicle["subtitle"],
            style: AppTextStyle.small14SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              color: AppColors.appTextColors,
            ),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.vechileDetailsPages.value, arguments: vehicle);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  vehicle["image"].toString().startsWith('http')
                      ? Image.network(
                        vehicle["image"],
                        height: 192,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImage.car2.value,
                            height: 192,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 192,
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.appBlackColor,
                              ),
                            ),
                          );
                        },
                      )
                      : Image.asset(
                        AppImage.car2.value,
                        height: 192,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(SvgImage.persons.value, height: 16),
                  const SizedBox(width: 6),
                  Text(
                    "${vehicle["seats"]} seats",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(SvgImage.bag.value, height: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${vehicle["bags"]} bags",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "per hour",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  Text(
                    vehicle["price"],
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
