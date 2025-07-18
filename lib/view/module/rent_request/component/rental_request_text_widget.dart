import 'package:flutter/material.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class RentelRequestTextWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const RentelRequestTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            color: const Color.fromRGBO(115, 115, 115, 1),
          ),
        ),
        Text(
          subTitle,
          style: AppTextStyle.small16SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ],
    );
  }
}
