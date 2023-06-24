import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xffDA8856);
  static const Color black = Color(0xff292C29);
  static const Color white = Color(0xffFFFFFF);
  static const Color brown = Color(0xffBBC4CE);
  static const Color black60 = Color(0xff292C29);
  static const Color background = Color(0xffFFFDF5);



  // Light colors
  static const primaryLightColor = Color(0xFF89ABAA);
  static const primaryColor = Color(0xFF6A8584);
  static const primaryDarker = Color(0xFF566B6A);
  static const secondaryColor = Color(0xFFFFCB42);
  static const scaffoldBackgroundColor = primaryColor;
  static const tasbeehCounterColor = Color(0xFF4B5E5E);
  static const iconColor = tasbeehCounterColor;

// Dark colors
  static const darkPrimaryLightColor = Color(0xFF6c757d);
  static const darkPrimaryColor = Color(0xFF393E46);
  static const darkPrimaryDarker = Color(0xFF292D33);
  static const darkSecondaryColor = Color(0xFFdee2e6);
  static const darkScaffoldBackgroundColor = Color(0xFF000000);
  static const darkTasbeehCounterColor = Color(0xFF4B5E5E);
  static const darkIconColor = Color(0xFFadb5bd);


  static const inputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.white,
      ),
    ),
  );

  static const dialogButtonTextStyle = TextStyle(
    fontSize: 16,
  );



 static const int _rubyPrimary=0xFF44000D;
 static const MaterialColor ruby=MaterialColor(
    _rubyPrimary,
    <int, Color>{
      50 : Color(0xFFF9F0F3),
      100 : Color(0xFFF4E1E6),
      200 : Color(0xFFEDCED6),
      300 : Color(0xFFE3B3C1),
      400 : Color(0xFFC86883),
      500 : Color(0xFFBB4364),
      600 : Color(0xFFAD1D45),
      700 : Color(0xFF83142C),
      800 : Color(_rubyPrimary),
      900 : Color(0xFF130307),
    },
  );
}