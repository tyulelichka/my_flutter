import 'package:flutter/material.dart';

class AddElement extends StatelessWidget {
  final String addName;
  final void Function(String) create;
  final taskController = TextEditingController();
  AddElement({super.key, required this.addName, required this.create});
  void handleSubmit() {
    String text = taskController.text.trim();
    if (text.isNotEmpty) {
      create(taskController.text);
      taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New $addName'),
      content: TextField(
        controller: taskController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Input new $addName',
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          handleSubmit();
          Navigator.of(context).pop(true);
        },
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          onPressed: () {
            handleSubmit();
            Navigator.of(context).pop(true);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}