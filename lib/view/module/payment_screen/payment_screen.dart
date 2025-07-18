import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: AppTextStyle.medium20SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
        centerTitle: true,
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              'Amount to Pay',
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: const Color.fromRGBO(115, 115, 115, 1),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$249.99',
              style: AppTextStyle.extraLarge34SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Invoice #INV-2025-001',
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: const Color.fromRGBO(115, 115, 115, 1),
              ),
            ),
            const SizedBox(height: 32),

            // Account Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.appGrayColor,
                        child: SvgPicture.asset(
                          SvgImage.building.value,
                          height: 20,
                          width: 15,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TechCorp Inc.',
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                              ),
                            ),
                            Text(
                              'Corporate Account',
                              style: AppTextStyle.small16SizeText.copyWith(
                                fontFamily: FontFamily.interRegular,
                                color: const Color.fromRGBO(115, 115, 115, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        SvgImage.correct.value,
                        height: 20,
                        width: 20,
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  _creditRow('Available Credit', '\$5,000.00'),
                  const SizedBox(height: 8),
                  _creditRow('Credit After Payment', '\$4,750.01'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Payment Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: AppTextStyle.small16SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _creditRow('Service Fee', '\$229.99'),
                  const SizedBox(height: 8),
                  _creditRow('Tax', '\$20.00'),
                  const Divider(height: 32),
                  _creditRow('Total', '\$249.99'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Confirm Payment Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Confirm Payment',
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: AppColors.appTextColor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(SvgImage.lock.value, height: 16, width: 14),
                SizedBox(width: 6),
                Text(
                  'Secure Corporate Payment',
                  style: AppTextStyle.small14SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: const Color.fromRGBO(115, 115, 115, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _creditRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            color: const Color.fromRGBO(115, 115, 115, 1),
          ),
        ),
        Text(
          value,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ],
    );
  }
}
