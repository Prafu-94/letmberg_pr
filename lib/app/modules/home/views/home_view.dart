import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letmberg_pr/app/data/widgets/custom_elevated_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomElevatedButton(
                label: 'Task One',
                icon: Icons.looks_one,
                onPressed: () => Get.toNamed(AppPages.TASK_ONE),
              ),
              const SizedBox(height: 12),
              CustomElevatedButton(
                label: 'Task Two',
                icon: Icons.looks_two,
                onPressed: () => Get.toNamed(AppPages.TASK_TWO),
              ),
              const SizedBox(height: 12),
              CustomElevatedButton(
                label: 'Task Three',
                icon: Icons.looks_3,
                onPressed: () => Get.toNamed(AppPages.TASK_THREE),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
