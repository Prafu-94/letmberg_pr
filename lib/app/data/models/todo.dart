import 'package:get/get.dart';

class Todo {
  String title;
  String description;
  String status;
  int totalSeconds;
  RxInt remainingSeconds;
  RxBool isRunning;

  Todo({
    required this.title,
    required this.description,
    this.status = 'TODO',
    required this.totalSeconds,
  }) : remainingSeconds = totalSeconds.obs,
        isRunning = false.obs;
}
