import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  static const TextStyle button = TextStyle(
      color: AppColors.grey800,
      fontSize: 14,
      fontFamily: "SF Pro Display",
      fontWeight: FontWeight.w600);

  static const TextStyle titleStyle = TextStyle(
      color: AppColors.grey800,
      fontSize: 24,
      fontFamily: "NeutralFace",
      fontWeight: FontWeight.bold);

  static const TextStyle buttonDark = TextStyle(
      color: AppColors.grey600, fontSize: 18, fontFamily: "SF Pro Display");

  static const TextStyle appBarStyle = TextStyle(
      color: AppColors.white, fontSize: 20, fontFamily: "SF Pro Display");

  static const TextStyle priceStyle = TextStyle(
      color: AppColors.grey800,
      fontSize: 18,
      fontFamily: "SF Pro Display",
      fontWeight: FontWeight.w500);

  static const TextStyle alertStyle = TextStyle(
      color: AppColors.white, fontSize: 16, fontFamily: "SF Pro Display");

  static const TextStyle hintStyle = TextStyle(
      color: AppColors.grey200, fontSize: 14, fontFamily: "SF Pro Display");
}
