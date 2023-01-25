import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF006e17);

  static const scaffoldBackgroundColor = Color(0xFFEFF0E8);
  static const backgroundColor = Color(0xFFE5E7D8);

  static const messageCard = Color(0xFFEFF0E8);
  static const avatarColor = Color(0xFFD3D4B9);
  static const textAvatarColor = Color(0xFFEFF0E8);
  static const avatarBorder = Color(0x42000000);
}

abstract class TxtStyle {
  // static const blender14 = TextStyle(fontFamily: 'blender', fontSize: 15);

  // static const content14 = TextStyle(fontSize: 14.0, fontFamily: 'play');

  // static const zelek14 = TextStyle(fontSize: 14.0, fontFamily: 'zelek');
}

final themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    colorScheme: ThemeData().colorScheme.copyWith(primary: AppColors.primary),
    backgroundColor: AppColors.backgroundColor);
