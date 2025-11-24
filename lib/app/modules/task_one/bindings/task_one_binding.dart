import 'package:get/get.dart';

import '../controllers/task_one_controller.dart';

class TaskOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskOneController>(
      () => TaskOneController(),
    );
  }
}
