import 'package:get/get.dart';

import '../controllers/task_two_controller.dart';

class TaskTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskTwoController>(
      () => TaskTwoController(),
    );
  }
}
