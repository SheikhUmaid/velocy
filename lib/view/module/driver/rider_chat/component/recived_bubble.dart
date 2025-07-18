import 'package:flutter/material.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class ReceiverBubble extends StatelessWidget {
  final String message;
  final String time;

  const ReceiverBubble({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Text(
            message,
            style: AppTextStyle.small14SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          time,
          style: AppTextStyle.small12SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(115, 115, 115, 1),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
