import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class PillButtonWidget extends StatelessWidget {
  final String? image;
  final String text;
  const PillButtonWidget({super.key, this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...[
            image != null
                ? SvgPicture.asset(image!, height: 16)
                : const SizedBox.shrink(),
            SizedBox(width: 10),
          ],
          Text(
            text,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ],
      ),
    );
  }
}
