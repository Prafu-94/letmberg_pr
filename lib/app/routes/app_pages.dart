import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/task_one/bindings/task_one_binding.dart';
import '../modules/task_one/views/task_one_view.dart';
import '../modules/task_three/bindings/task_three_binding.dart';
import '../modules/task_three/views/task_three_view.dart';
import '../modules/task_two/bindings/task_two_binding.dart';
import '../modules/task_two/views/task_two_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const TASK_ONE = Routes.TASK_ONE;
  static const TASK_TWO = Routes.TASK_TWO;
  static const TASK_THREE = Routes.TASK_THREE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TASK_ONE,
      page: () => const TaskOneView(),
      binding: TaskOneBinding(),
    ),
    GetPage(
      name: _Paths.TASK_TWO,
      page: () => TaskTwoView(),
      binding: TaskTwoBinding(),
    ),
    GetPage(
      name: _Paths.TASK_THREE,
      page: () => TaskThreeView(),
      binding: TaskThreeBinding(),
    ),
  ];
}
