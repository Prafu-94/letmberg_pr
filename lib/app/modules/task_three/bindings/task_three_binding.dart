import 'package:get/get.dart';

import '../controllers/task_three_controller.dart';

class TaskThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskThreeController>(
      () => TaskThreeController(),
    );
  }
}
