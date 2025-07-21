import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/local_storage/secure_storage.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/buttons_widget.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/rental/vehicle_details/ui/widget/vechile_box_card_widget.dart';

class VechileDetailsWidget extends StatefulWidget {
  const VechileDetailsWidget({super.key});

  @override
  State<VechileDetailsWidget> createState() => _VechileDetailsWidgetState();
}

class _VechileDetailsWidgetState extends State<VechileDetailsWidget> {
  String rentalDuration = '4 Hours';
  final List<String> durations = ['1 Hour', '4 Hours', '8 Hours', '1 Day'];

  DateTime? pickupDateTime;
  DateTime? dropoffDateTime;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Vehicle Details",
        centerTitle: true,
        appElevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.rentalOwnerDetails.value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset(SvgImage.profile.value),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.car2.value),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Toyota Innova Crysta",
                        style: AppTextStyle.medium20SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.boxColors,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          "SUV",
                          style: AppTextStyle.small14SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(SvgImage.rating.value, height: 16),
                      SizedBox(width: 8),
                      Text(
                        "(4.2)",
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "₹1,200 ",
                    style: AppTextStyle.medium24SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  Text(
                    "/hour",
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VehicleFeatureCard(
                        title: 'Capacity',
                        subTitle: '7 Seater',
                        icons: SvgImage.capacity.value,
                      ),
                      VehicleFeatureCard(
                        title: 'AC',
                        subTitle: 'Yes',
                        icons: SvgImage.ac.value,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VehicleFeatureCard(
                        title: 'Fuel',
                        subTitle: 'Diesel',
                        icons: SvgImage.fuel.value,
                      ),
                      VehicleFeatureCard(
                        title: 'Transmission',
                        subTitle: 'Automatic',
                        icons: SvgImage.settings.value,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rental Duration",
                        style: AppTextStyle.small16SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.boxColors),
                        ),
                        child: DropdownButton<String>(
                          value: rentalDuration,
                          onChanged: (String? newValue) {
                            setState(() {
                              rentalDuration = newValue!;
                            });
                          },
                          items:
                              durations.map<DropdownMenuItem<String>>((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: AppTextStyle.small16SizeText
                                        .copyWith(
                                          fontFamily: FontFamily.interRegular,
                                        ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Pickup Time",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectPickupDateTime(context),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pickupDateTime != null
                                ? _formatDateTime(pickupDateTime!)
                                : "Select pickup date & time",
                            style: AppTextStyle.medium18SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                              color:
                                  pickupDateTime != null
                                      ? Colors.black
                                      : Colors.grey.shade600,
                            ),
                          ),
                          const Icon(Icons.calendar_today, size: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Drop Time",
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: AppColors.appTextColors,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDropoffDateTime(context),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dropoffDateTime != null
                                ? _formatDateTime(dropoffDateTime!)
                                : "Select drop date & time",
                            style: AppTextStyle.medium18SizeText.copyWith(
                              fontFamily: FontFamily.interRegular,
                              color:
                                  dropoffDateTime != null
                                      ? Colors.black
                                      : Colors.grey.shade600,
                            ),
                          ),
                          const Icon(Icons.calendar_today, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 32),
                  Center(
                    child: Text(
                      'Free cancellation up to 24 hours before pickup',
                      style: AppTextStyle.small12SizeText.copyWith(
                        fontFamily: FontFamily.interRegular,
                        color: AppColors.appTextColors,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      height: 48,
                      onPressed: isLoading ? null : _rentNow,
                      title: isLoading ? "Processing..." : "Rent Now",
                      color: AppColors.appBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectPickupDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          pickupDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _selectDropoffDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: pickupDateTime ?? DateTime.now(),
      firstDate: pickupDateTime ?? DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          dropoffDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String _formatDateTimeForAPI(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00";
  }

  Future<void> _rentNow() async {
    // Validation
    if (pickupDateTime == null || dropoffDateTime == null) {
      Get.snackbar(
        "Error",
        "Please select both pickup and drop times",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (dropoffDateTime!.isBefore(pickupDateTime!)) {
      Get.snackbar(
        "Error",
        "Drop time cannot be before pickup time",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await _makeRentRequest();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Vehicle rental request submitted successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to confirmation or booking details page
        // Get.toNamed(Routes.bookingConfirmation.value);
      } else {
        final responseBody = json.decode(response.body);
        Get.snackbar(
          "Error",
          responseBody['message'] ?? "Failed to submit rental request",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network error: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<http.Response> _makeRentRequest() async {
    const String apiUrl =
        "https://82.25.104.152/rent/rent-request/4/"; // Replace with your actual API URL

    final Map<String, String> requestBody = {
      'pickup_datetime': _formatDateTimeForAPI(pickupDateTime!),
      'dropoff_datetime': _formatDateTimeForAPI(dropoffDateTime!),
      'lessor_id':
          '7', // You might want to make this dynamic based on the vehicle
    };
    final accessToken = await SecureStorage().getAccessToken();

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        // Add any authorization headers if needed
        'Authorization': 'Bearer $accessToken',
      },
      body: requestBody,
    );

    debugPrint(response.toString());

    return response;
  }
}
