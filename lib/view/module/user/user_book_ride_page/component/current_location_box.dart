import 'package:flutter/material.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/utils/app_colors.dart';

class CurrentLocationBox extends StatelessWidget {
  final String? address;

  const CurrentLocationBox({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      width: double.infinity,
      color: AppColors.appWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Current Location", style: AppTextStyle.medium18SizeText),
          SizedBox(height: 6),
          Text(address ?? "Fetching address...",
              style: AppTextStyle.small14SizeText.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}
