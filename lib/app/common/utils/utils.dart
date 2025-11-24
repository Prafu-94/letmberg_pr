import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letmberg_pr/app/data/theme/app_colors.dart';

class Utils {
  void showCoustomSnackBar({
    @required String? title,
    String? subTitle,
    Color? color,
  }) {
    Get.snackbar(
      title ?? '',
      subTitle ?? '',
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      margin: const EdgeInsets.all(4),
      backgroundColor: AppColors.blackColor,
      colorText: AppColors.whiteColor,
    );
  }
}
