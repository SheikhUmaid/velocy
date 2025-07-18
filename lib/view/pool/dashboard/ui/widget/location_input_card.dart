import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/textfield.dart';

class LocationInputCard extends StatelessWidget {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  LocationInputCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _locationField(
                icon: SvgImage.round.value,
                hint: "Leaving from",
                controller: fromController,
                suffixIcon: SvgImage.leaveLocation.value,
              ),
              SizedBox(height: 8),
              _locationField(
                icon: SvgImage.location.value,
                hint: "Going to",
                controller: toController,
              ),
            ],
          ),
        ),

        // Switch Icon (centered)
        Positioned(
          right: 90,
          top: 60,
          child: SvgPicture.asset(SvgImage.rounded.value),
        ),
      ],
    );
  }

  Widget _locationField({
    required String icon,
    required String hint,
    String? suffixIcon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: PrimaryTextField(
              hintText: hint,
              enableBorder: false,
              // prefixIcon: Icons.dangerous,
              suffixIcon:
                  suffixIcon != null
                      ? SvgPicture.asset(suffixIcon!, height: 16)
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
