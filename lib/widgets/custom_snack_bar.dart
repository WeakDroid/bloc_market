import 'package:flutter/material.dart';
import 'package:bloc_market_app/styles/colors.dart';
import '../styles/text_styles.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String text,
    IconData? icon,
    Color? iconColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.grey400,
        content: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColors.neon,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: AppTextStyles.alertStyle,
            ),
          ],
        ),
      ),
    );
  }
}
