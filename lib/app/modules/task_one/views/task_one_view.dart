import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_one_controller.dart';

class TaskOneView extends GetWidget<TaskOneController> {
  const TaskOneView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TaskOneView'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: const Text(
                'Object Base Counts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            controller.saprateCollection.isEmpty
                ? const Center(child: Text('No entries'))
                : ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.saprateCollection.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final map = controller.saprateCollection[index];
                    final formatted = map.entries
                        .map((e) => '${e.key}(${e.value})')
                        .join(', ');
                    return ListTile(
                      title: Text('Row ${index + 1}'),
                      subtitle: Text(
                        formatted.isEmpty ? 'No animals' : formatted,
                      ),
                    );
                  },
                ),
            const SizedBox(height: 8),
            const Text(
              'Total Counts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            controller.animalCounts.isEmpty
                ? const Text('No data available')
                : Column(
                  children:
                      controller.animalCounts.keys
                          .map(
                            (k) => ListTile(
                              title: Text(k),
                              trailing: Text('(${controller.animalCounts[k]})'),
                            ),
                          )
                          .toList(),
                ),
          ],
        ),
      ),
    );
  }
}
