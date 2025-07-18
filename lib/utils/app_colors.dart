import 'package:flutter/material.dart';

class AppColors {
  ///Colors Utils

  static const Color appGrayColor = Color(0xffEDEEF0);
  static const Color appBgColor = Color(0xFFFAFAFA);
  static const Color appBlackColor = Color(0xff000000);
  static const Color appBlackColor2626 = Color(0xff262626);
  static const Color appWhiteColor = Color(0xffFFFFFF);
  static const Color appRedColor = Color(0xffF04438);
  static const Color appTextColor = Color(0xffFFFFFF);
  static const Color appTextGrayColor = Color(0xffADAEBC);
  static const Color appGrayColorE5 = Color(0xFFE5E5E5);
  static const Color appColorF5 = Color(0xFFF5F5F5);
  static const Color appGrayColorF2 = Color(0xFFF2F2F2);
  static const Color appGrayColoD42 = Color(0xFFD4D4D4);
  static const Color appTextDarkGrayColor = Color(0xff777B84);
  static const Color appDarkGrayColor = Color(0xff5A6169);
  static const Color appDarkGrayColor73 = Color(0xFF737373);
  static const Color appGrayColor52 = Color(0xFF525252);
  static const Color appBorderGrayColor = Color(0xffE5E7EB);
  static const Color appSuccessColor = Color(0xff4EBD71);
  static const Color appErrorColor = Color(0xffF04438);
  static const Color appTransparentColor = Colors.transparent;
  static const Color appTextColors = Color.fromRGBO(115, 115, 115, 1);
  static const Color boxColors = Color.fromRGBO(229, 231, 235, 1);
}

class AppGradientColors {
  static final List<Color> primaryGradient = [
    const Color(0xff4C6CAD).withOpacity(0.7),
    const Color(0xff395DB6).withOpacity(0.7),
  ];
}

Map<int, Color> color = {
  050: const Color.fromRGBO(76, 108, 173, .1),
  100: const Color.fromRGBO(76, 108, 173, .2),
  200: const Color.fromRGBO(76, 108, 173, .3),
  300: const Color.fromRGBO(76, 108, 173, .4),
  400: const Color.fromRGBO(76, 108, 173, .5),
  500: const Color.fromRGBO(76, 108, 173, .6),
  600: const Color.fromRGBO(76, 108, 173, .7),
  700: const Color.fromRGBO(76, 108, 173, .8),
  2090: const Color.fromRGBO(76, 108, 173, .9),
  900: const Color.fromRGBO(76, 108, 173, 1.0),
};

MaterialColor colorCustom = MaterialColor(0xff395DB6, color);
