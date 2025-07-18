import 'package:flutter/material.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class SendBubble extends StatelessWidget {
  final String message;
  final String time;
  const SendBubble({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(19),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Text(
            message,
            style: AppTextStyle.small14SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          time,
          style: AppTextStyle.small14SizeText.copyWith(
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
