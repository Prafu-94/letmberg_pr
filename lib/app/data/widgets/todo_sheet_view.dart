import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoSheetView extends StatelessWidget {
  Todo? todo;
  int? ind;
  TextEditingController? titleController;
  TextEditingController? descController;
  TextEditingController? timeController;

  TodoSheetView({
    @required this.todo,
    @required this.ind,
    @required this.titleController,
    @required this.timeController,
    @required this.descController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              todo == null ? 'Add TODO' : 'Edit TODO',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Title";
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: descController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Description";
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: timeController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Time";
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Time (min, max 5)'),
              keyboardType: TextInputType.number,
              maxLength: 1,
            ),
          ],
        ),
      ),
    );
  }
}
