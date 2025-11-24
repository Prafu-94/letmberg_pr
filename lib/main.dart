import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:letmberg_pr/app/data/theme/app_theme.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: AppTheme.defaultTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
