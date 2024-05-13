import 'package:flutter/material.dart';
import 'package:flutter_template/core/app_color.dart';

class AppTheme {
  static AppTheme? _instance;

  AppTheme._();

  factory AppTheme() => _instance ??= AppTheme._();

  ThemeData lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor().lightBlack,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
