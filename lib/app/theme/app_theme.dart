import 'package:flutter/material.dart';

import 'color_theme.dart';

enum AppTheme {
  RedLight,
  RedDark,
}

final appThemeData = {
  AppTheme.RedLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryRed,
    scaffoldBackgroundColor: white1,
    primaryColorLight: white2,
    primaryColorDark: secondaryDBlue,
  ),
  AppTheme.RedDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryRed,
    scaffoldBackgroundColor: primaryDBlue,
    primaryColorDark: white2,
    primaryColorLight: secondaryDBlue,
  ),
};