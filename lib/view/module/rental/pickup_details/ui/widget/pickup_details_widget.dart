import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/rental/pickup_details/ui/widget/card_widget.dart';
import 'package:velocy_user_app/widgets/primary_button.dart';

class PickUpDetailsWidget extends StatefulWidget {
  const PickUpDetailsWidget({super.key});

  @override
  State<PickUpDetailsWidget> createState() => _PickUpDetailsWidgetState();
}

class _PickUpDetailsWidgetState extends State<PickUpDetailsWidget> {
  // Checklist items
  final List<ChecklistItem> _checklistItems = [
    ChecklistItem(title: 'Car Keys'),
    ChecklistItem(title: 'Vehicle Documents'),
    ChecklistItem(title: 'Fuel Tank Full'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pickup Details',
          style: AppTextStyle.medium20SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
        centerTitle: true,
        leading: const BackButton(),

        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Information Card
              _buildVehicleInfoCard(),

              const SizedBox(height: 24),

              // Checklist Section
              Text(
                'Handover Checklist',
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appBlackColor,
                ),
              ),
              const SizedBox(height: 12),
              _buildChecklist(),

              const SizedBox(height: 24),

              // Payment Details Section
              Text(
                'Payment Details',
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              const SizedBox(height: 8),
              _buildPaymentDetails(),

              const SizedBox(height: 32),
              Text(
                'Select Payment Method',
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appBlackColor,
                ),
              ),
              const SizedBox(height: 10),

              CardWidget(
                title: 'Credit/Debit Card',
                image: SvgImage.card.value,
              ),
              const SizedBox(height: 10),
              CardWidget(title: 'PayPal', image: SvgImage.paypal.value),
              const SizedBox(height: 10),
              CardWidget(title: 'Apple Pay', image: SvgImage.applepay.value),
              const SizedBox(height: 10),
              // Complete Handover Button
              PrimaryButton(
                onPressed: () {},
                text: "Pay & pickup",
                height: 56,
                borderRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.directions_car,
              size: 32,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Toyota Camry 2025',
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'License: ABC 123',
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appTextColors,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChecklist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          _checklistItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      activeColor: AppColors.appBlackColor,

                      value: item.isChecked,

                      checkColor: AppColors.appGrayColor,
                      onChanged: (bool? value) {
                        setState(() {
                          item.isChecked = value ?? false;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.title,
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      children: [
        _buildPaymentRow('Rental Fee', '\$120.00'),
        const SizedBox(height: 9),
        _buildPaymentRow('Security Deposit', '\$200.00'),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        _buildPaymentRow('Total Amount', '\$320.00'),
      ],
    );
  }

  Widget _buildPaymentRow(String label, String amount, {bool isBold = false}) {
    final textStyle = TextStyle(
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontSize: isBold ? 16 : 14,
      fontFamily: FontFamily.interRegular,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: textStyle), Text(amount, style: textStyle)],
    );
  }
}

class ChecklistItem {
  final String title;
  bool isChecked;

  ChecklistItem({required this.title, this.isChecked = false});
}
