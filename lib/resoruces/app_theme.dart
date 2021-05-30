import 'package:flutter/material.dart';
import 'package:weather/consetance/enums.dart';

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue.shade200,
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
  )
};
