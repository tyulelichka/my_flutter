import 'package:flutter/material.dart';

class AddElement extends StatelessWidget {
  final TextEditingController taskController;
  final String addName;
  final void Function() create;

  const AddElement({
    super.key,
    required this.addName,
    required this.taskController,
    required this.create,
  });
  void handleSubmit() {
    String text = taskController.text.trim();
    if (text.isNotEmpty) {
      create();
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
