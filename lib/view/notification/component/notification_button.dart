import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class NotificationActionButton extends StatelessWidget {
  final String title;
  final String? icons;
  final Color colors;
  final Color backgroungColors;
  const NotificationActionButton({
    super.key,
    required this.title,
    this.icons,
    required this.colors,
    required this.backgroungColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: backgroungColors,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromRGBO(229, 229, 229, 1)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...[
            icons != null
                ? SvgPicture.asset(icons!, color: colors)
                : SizedBox.shrink(),
            SizedBox(width: 10),
          ],
          Text(
            title,
            style: AppTextStyle.small16SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
              color: colors,
            ),
          ),
        ],
      ),
    );
  }
}
