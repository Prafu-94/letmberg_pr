import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/todo.dart';

class DetailsSheet extends StatelessWidget {
  final Todo todo;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onStop;
  final VoidCallback onEdit;

  const DetailsSheet({super.key,
    required this.todo,
    required this.onPlay,
    required this.onPause,
    required this.onStop,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(todo.description),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(label: Text(todo.status)),
              const SizedBox(width: 8),
              const Icon(Icons.timer, size: 16),
              const SizedBox(width: 2),
              Obx(
                    () => Text(
                  '${(todo.remainingSeconds.value ~/ 60).toString().padLeft(2, '0')}:${(todo.remainingSeconds.value % 60).toString().padLeft(2, '0')}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Obx(
                    () =>  IconButton(
                  icon:todo.isRunning.value ? const Icon(Icons.pause):const Icon(Icons.play_arrow),
                  onPressed: todo.isRunning.value ? onPause : onPlay,
                ),
              ),
              IconButton(icon: const Icon(Icons.stop), onPressed: onStop),
              const Spacer(),
              IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            ],
          ),
        ],
      ),
    );
  }
}