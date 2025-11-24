import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:letmberg_pr/app/data/widgets/todo_sheet_view.dart';
import '../../../common/utils/utils.dart';
import '../../../data/models/todo.dart';
import '../../../data/models/todo_hive_adapter.dart';
import '../../../data/widgets/details_sheet.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class TaskTwoController extends GetxController {
  final todos = <Todo>[].obs;
  final _timers = <int, Timer>{};
  late Box todoBox;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Rx<Todo?> editingTodo = Rx<Todo?>(null);
  RxInt editingIndex = (-1).obs;
  final RxString searchQuery = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initHive();
    await _initNotifications();
    _loadFromBox();
  }

  @override
  void onClose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    super.onClose();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(TodoHiveAdapter());
    todoBox = await Hive.openBox('todosBox');
  }

  void _loadFromBox() {
    final stored = todoBox.get('todos') as List<dynamic>?;
    if (stored != null) {
      todos.clear();
      for (final item in stored) {
        if (item is TodoHive) {
          todos.add(item.toTodo());
        }
      }
    }
  }

  Future<void> _saveToBox() async {
    try {
      final list = todos.map((t) => TodoHive.fromTodo(t)).toList();
      await todoBox.put('todos', list);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: android);
    await _notificationsPlugin.initialize(initSettings);

    const channel = AndroidNotificationChannel(
      'todo_channel',
      'Todo Notifications',
      description: 'Notifications for todo completion',
      importance: Importance.max,
    );
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    try {
      final status = await Permission.notification.status;
      if (status.isDenied) {
        final result = await Permission.notification.request();
        if (result.isPermanentlyDenied) {
          Utils().showCoustomSnackBar(
            title: 'Notification permission',
            subTitle: 'Please enable notifications from app settings',
          );
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> _showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'todo_channel',
      'Todo Notifications',
      channelDescription: 'Notifications for todo completion',
      importance: Importance.max,
      priority: Priority.high,
    );

    try {
      await _notificationsPlugin.show(
        DateTime.now().day/*.millisecondsSinceEpoch ~/ 1000*/,
        title,
        body,
        NotificationDetails(android: androidDetails),
      );
      print("object");
    } catch (e) {
      print(e);
    }
  }

  List<Todo> get filteredTodos {
    if (searchQuery.value.isEmpty) return todos;
    return todos
        .where(
          (t) =>
              t.title.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'TODO':
        return Colors.grey.shade400;
      case 'In-Progress':
        return Colors.blue.shade300;
      case 'Done':
        return Colors.green.shade400;
      default:
        return Colors.grey;
    }
  }

  String getFormattedTime(Todo todo) {
    final seconds = todo.remainingSeconds.value;
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  void deleteTodo(int index) {
    _timers[index]?.cancel();
    _timers.remove(index);
    todos.removeAt(index);
    _saveToBox();
  }

  void openDetails(BuildContext context, Todo todo) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => DetailsSheet(
            todo: todo,
            onPlay: () {
              startTimer(todo);
              Get.back();
            },
            onPause: () {
              pauseTimer(todo);
              Get.back();
            },
            onStop: () {
              stopTimer(todo);
              Get.back();
            },
            onEdit:
                () => openAddTodoForm(
                  context,
                  todo: todo,
                  ind: todos.indexOf(todo),
                ),
          ),
    );
  }

  void todoValidate({
    @required TextEditingController? titleController,
    @required TextEditingController? descController,
    @required TextEditingController? timeController,
    @required Todo? todo,
    @required int? index,
  }) {
    final title = titleController!.text.trim();
    final desc = descController!.text.trim();
    final min = int.tryParse(timeController!.text.trim()) ?? 0;
    if (min < 1 || min > 5) {
      Utils().showCoustomSnackBar(
        title: "Enter valid duration",
        subTitle: "Max duration is 5 min",
      );
      return;
    }
    final seconds = min * 60;
    if (todo == null) {
      todos.add(Todo(title: title, description: desc, totalSeconds: seconds));
    } else if (index != null && index >= 0) {
      todos[index] = Todo(
        title: title,
        description: desc,
        totalSeconds: seconds,
        status: todo.status,
      );
    }
    _saveToBox();
    Get.back();
  }

  void openAddTodoForm(BuildContext context, {Todo? todo, int? ind}) {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descController = TextEditingController(text: todo?.description ?? '');
    final timeController = TextEditingController(
      text: todo != null ? (todo.totalSeconds ~/ 60).toString() : '',
    );
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TodoSheetView(
                    descController: descController,
                    todo: todo,
                    titleController: titleController,
                    ind: ind,
                    timeController: timeController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            todoValidate(
                              index: ind,
                              descController: descController,
                              timeController: timeController,
                              titleController: titleController,
                              todo: todo,
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void startTimer(Todo todo) {
    if (todo.status == 'Done') return;
    todo.status = 'In-Progress';
    todo.isRunning.value = true;
    final idx = todos.indexOf(todo);
    _timers[idx]?.cancel();
    _timers[idx] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (todo.remainingSeconds.value > 0) {
        todo.remainingSeconds.value--;
      } else {
        timer.cancel();
        todo.status = 'Done';
        todo.isRunning.value = false;
        _saveToBox();
        _showNotification('${todo.title} completed', todo.description);
        todos.refresh();
        update();
      }
    });
    _saveToBox();
    todos.refresh();
    update();
  }

  void pauseTimer(Todo todo) {
    todo.isRunning.value = false;
    final idx = todos.indexOf(todo);
    _timers[idx]?.cancel();
    _saveToBox();
    todos.refresh();
    update();
  }

  void stopTimer(Todo todo) {
    final idx = todos.indexOf(todo);
    _timers[idx]?.cancel();
    todo.isRunning.value = false;
    todo.status = 'TODO';
    todo.remainingSeconds.value = todo.totalSeconds;
    _saveToBox();
    todos.refresh();
    update();
  }
}
