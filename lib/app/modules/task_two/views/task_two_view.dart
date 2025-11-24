import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_two_controller.dart';

class TaskTwoView extends GetView<TaskTwoController> {
  TaskTwoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (v) => controller.searchQuery.value = v,
              decoration: InputDecoration(
                hintText: 'Search TODOs...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        final todos = controller.filteredTodos;
        if (todos.isEmpty) {
          return const Center(child: Text('No TODOs yet.'));
        }
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(todo.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todo.description),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Chip(
                          label: Text(todo.status),
                          backgroundColor: controller.getStatusColor(
                            todo.status,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.timer, size: 16),
                        const SizedBox(width: 2),
                        Obx(() => Text(controller.getFormattedTime(todo))),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed:
                      () =>
                          controller.deleteTodo(controller.todos.indexOf(todo)),
                ),
                onTap: () => controller.openDetails(context, todo),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.openAddTodoForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
