import 'package:flutter/material.dart';
import 'colors.dart';

class AppStyles {
  static const title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.text,
  );

   static const caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary, // atau Colors.grey
  );
}


