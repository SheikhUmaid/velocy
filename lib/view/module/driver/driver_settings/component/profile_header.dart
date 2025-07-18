import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String arrow;
  final double height;
  const ProfileHeader({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.arrow,
    required this.height,
  });
  bool _isNetworkImage(String url) => url.startsWith('http');
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child:
              _isNetworkImage(image)
                  ? Image.network(
                    image,
                    width: height,
                    height: height,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.account_circle, size: height);
                    },
                  )
                  : SvgPicture.asset(image, width: height, height: height),
        ),

        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            SizedBox(height: 2),
            Text(
              subTitle,
              style: AppTextStyle.small14SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
                color: const Color.fromRGBO(115, 115, 115, 1),
              ),
            ),
          ],
        ),
        Spacer(),

        SvgPicture.asset(arrow, width: 16, height: 16),
      ],
    );
  }
}
