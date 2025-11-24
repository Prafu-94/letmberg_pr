import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:letmberg_pr/app/data/theme/app_colors.dart';
import 'package:letmberg_pr/app/modules/task_three/controllers/task_three_controller.dart';

class TaskThreeView extends GetView<TaskThreeController> {
  TaskThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller.pageController,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, ind) {
          controller.textColor(Colors.white);
          if (controller.currentPage.value <= controller.colors.length) {
            print(
              "we want index::${controller.currentPage.value == 0 ? 0 : controller.currentPage.value - 1}",
            );
            return Container(
              alignment: Alignment(0, 0),
              color:
                  controller.colors[controller.currentPage.value == 0
                      ? 0
                      : controller.currentPage.value - 1],
              child: Obx(
                () => Stack(
                  children: [
                    Positioned(
                      top: Get.height * 0.34,
                      left: Get.width * 0.12,
                      child: Text(
                        controller
                            .horizontalString[controller.currentPage.value == 0
                            ? 0
                            : controller.currentPage.value - 1],
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: controller.textColor.value,
                          fontSize: 22,
                        ),
                      ).animate(delay: Duration(seconds: 1)).slideY(end: -1),
                    ),
                    Positioned(
                      top: Get.height * 0.36,
                      left: Get.width * 0.88,
                      child: SizedBox(
                        height: Get.height * 0.34,
                        width: Get.width * 0.84,
                        child: Text(
                          controller
                              .verticleString[controller.currentPage.value == 0
                              ? 0
                              : controller.currentPage.value - 1],
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 22,
                          ),
                        ),
                      ).animate(delay: Duration(seconds: 1)).slideX(end: -0.92),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}
