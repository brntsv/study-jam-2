import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF006e17);

  static const scaffoldBackgroundColor = Color(0xFFEFF0E8);
  static const backgroundColor = Color(0xFFE5E7D8);

  static const messageCard = Color(0xFFEFF0E8);
  static const avatarColor = Color(0xFFD3D4B9);
  static const textAvatarColor = Colors.black26;
  static const avatarBorder = Colors.black;
}

final themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
  colorScheme: ThemeData().colorScheme.copyWith(
      primary: AppColors.primary, background: AppColors.backgroundColor),
);

class AppImages {
  AppImages._();

  static const String peesetz = 'assets/images/peesetz.jpg';
}
