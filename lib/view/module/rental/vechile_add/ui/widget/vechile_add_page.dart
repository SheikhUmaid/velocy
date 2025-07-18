import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/custom_appbar.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class VechileAddPageWidget extends StatefulWidget {
  @override
  _VechileAddPageWidgetState createState() => _VechileAddPageWidgetState();
}

class _VechileAddPageWidgetState extends State<VechileAddPageWidget> {
  final TextEditingController vehicleNameController = TextEditingController(
    text: "XUV",
  );
  final TextEditingController regNumberController = TextEditingController(
    text: "84-545-515",
  );
  final TextEditingController priceController = TextEditingController(
    text: "\$120",
  );

  String? selectedType;
  String? selectedFuel = "Petrol";
  String? selectedTransmission = "Manual";
  String? selectedSeating = "2";
  String? selectedAvailability = "Available";
  bool hasAC = false;

  final List<String> vehicleTypes = ["Sedan", "SUV", "Hatchback"];
  final List<String> fuelTypes = ["Petrol", "Diesel", "Electric"];
  final List<String> transmissions = ["Manual", "Automatic"];
  final List<String> seatingCapacities = ["2", "4", "5", "7"];
  final List<String> availability = ["Available", "Unavailable"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Your Vehicle"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload Vehicle Photos",
              style: AppTextStyle.small14SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                // color: AppColors.appTextDarkGrayColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _vehicleImage(AppImage.car2.value),
                const SizedBox(width: 12),
                _vehicleImage(AppImage.car3.value),
                const SizedBox(width: 12),
              ],
            ),
            SizedBox(height: 13),
            _addPhotoBox(),
            const SizedBox(height: 24),
            TitleWidget(title: 'Vehicle Name'),
            SizedBox(height: 10),
            _textField("", vehicleNameController),
            const SizedBox(height: 16),
            TitleWidget(title: 'Vehicle Type'),
            SizedBox(height: 10),
            _dropdownField("", vehicleTypes, selectedType, (val) {
              setState(() => selectedType = val);
            }),
            const SizedBox(height: 16),
            TitleWidget(title: 'Registration Number'),
            SizedBox(height: 10),
            _textField("", regNumberController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _dropdownField(
                    "Seating Capacity",
                    seatingCapacities,
                    selectedSeating,
                    (val) {
                      setState(() => selectedSeating = val);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _dropdownField("Fuel Type", fuelTypes, selectedFuel, (
                    val,
                  ) {
                    setState(() => selectedFuel = val);
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _dropdownField(
                    "Transmission",
                    transmissions,
                    selectedTransmission,
                    (val) {
                      setState(() => selectedTransmission = val);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      const Text("AC"),
                      const Spacer(),
                      Switch(
                        value: hasAC,
                        onChanged: (val) {
                          setState(() => hasAC = val);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TitleWidget(title: 'Rental Price per Day'),
            const SizedBox(height: 10),
            _textField("", priceController, keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            TitleWidget(title: 'Available or Not'),
            const SizedBox(height: 10),
            _dropdownField("", availability, selectedAvailability, (val) {
              setState(() => selectedAvailability = val);
            }),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: () {},
              text: "Submit Vehicle for Approval",
              height: 48,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _textField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,

      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _dropdownField(
    String label,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items:
          items
              .map((val) => DropdownMenuItem(value: val, child: Text(val)))
              .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _vehicleImage(String path, {bool showClose = false}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(path, width: 170, height: 173, fit: BoxFit.cover),
        ),
        if (showClose)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16),
            ),
          ),
      ],
    );
  }

  Widget _addPhotoBox() {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      dashPattern: [6, 3],
      child: Container(
        width: 173,
        height: 173,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(child: Icon(Icons.add, color: Colors.grey)),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.small14SizeText.copyWith(
        fontFamily: FontFamily.interRegular,
        // color: AppColors.appTextDarkGrayColor,
      ),
    );
  }
}
