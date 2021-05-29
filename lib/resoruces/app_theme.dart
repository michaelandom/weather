import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }
enum InternetType { Wifi, Mobile }
final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue.shade200,
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
  )
};
