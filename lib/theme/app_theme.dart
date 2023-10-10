import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightBackgroundColor = const Color(0xffffffff);
  static Color lightPrimaryColor = const Color(0xff6E247F);
  static Color lightSecondaryColor = const Color(0xff040415);
  static Color lightAccentColor = Colors.blueGrey.shade200;
  static Color lightParticlesColor = const Color(0x44948282);
  static Color lightGrayTextColor = const Color(0xff4D5659);
  static Color lightGrayColor = const Color(0xffeeeeee);
  static Color lightMediumGrayColor = const Color(0xffDEDEDE);
  static Color lightBlueTextColor = const Color(0xff0A51A5);
  static Color lightTextColor = Colors.black54;
  static Color lightTextBlackColor = Colors.black;
  static Color lightWhiteTextColor = Colors.white;
  static Color lightWhite50 = const Color(0x80ffffff);
  static Color lightGreen = const Color(0xff36D328);
  static Color lightRed = const Color(0xffFF2626);
  static Color lightGray = const Color(0xFFB9B8B8);
  static Color lightLighterGray = const Color(0xFFECECEC);
  static Color lightDarkGray = const Color(0xFF4D5659);

  static void updateLightPrimaryColor(Color newColor) {
    lightPrimaryColor = newColor;
  }

  const AppTheme._();

  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Inter',
      primaryColor: lightPrimaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      backgroundColor: lightBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(backgroundColor: lightPrimaryColor),
      colorScheme: ColorScheme.light(secondary: lightSecondaryColor),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: lightBackgroundColor))
  );

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance!.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: lightBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}