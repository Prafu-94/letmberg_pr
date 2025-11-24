import 'package:hive/hive.dart';
import 'todo.dart';
part 'todo_hive_adapter.g.dart';

@HiveType(typeId: 0)
class TodoHive extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String status;
  @HiveField(3)
  int totalSeconds;
  @HiveField(4)
  int remainingSeconds;

  TodoHive({
    required this.title,
    required this.description,
    required this.status,
    required this.totalSeconds,
    required this.remainingSeconds,
  });

  factory TodoHive.fromTodo(Todo todo) => TodoHive(
    title: todo.title,
    description: todo.description,
    status: todo.status,
    totalSeconds: todo.totalSeconds,
    remainingSeconds: todo.remainingSeconds.value,
  );

  Todo toTodo() => Todo(
    title: title,
    description: description,
    status: status,
    totalSeconds: totalSeconds,
  )..remainingSeconds.value = remainingSeconds;
}
