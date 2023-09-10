import 'package:flutter/material.dart';
import 'colors.dart';

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.darkNeon,
    fixedSize: const Size(double.infinity, 55),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));

ButtonStyle productCountStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.white,
    fixedSize: const Size(44, 44),
    side: const BorderSide(color: AppColors.grey200, width: 0.6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
