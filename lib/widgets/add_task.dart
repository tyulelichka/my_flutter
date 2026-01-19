import 'package:flutter/material.dart';

class AddElement extends StatefulWidget {
  final String addName;
  final void Function(String) create;

  const AddElement({super.key, required this.addName, required this.create});

  @override
  State<AddElement> createState() => _AddElementState();
}

class _AddElementState extends State<AddElement> {
  final TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void handleSubmit() {
    final text = taskController.text.trim();
    if (text.isNotEmpty) {
      widget.create(text);
      taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New ${widget.addName}'),
      content: TextField(
        controller: taskController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Input new ${widget.addName}',
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          handleSubmit();
          Navigator.of(context).pop(true);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
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
