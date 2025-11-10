import 'package:flutter/material.dart';

class AddElement extends StatelessWidget {
  final TextEditingController inputName;
  final String addName;
  final void Function() create;

  const AddElement({
    super.key,
    required this.addName,
    required this.inputName,
    required this.create,
  });

  @override
  Widget build(BuildContext context) {
    void handleSubmit() {
      String text = inputName.text.trim();
      if (text.isNotEmpty) {
        create();
        inputName.clear();
        Navigator.of(context).pop(true);
      }
    }

    return AlertDialog(
      title: Text('New $addName'),
      content: TextField(
        controller: inputName,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Input new $addName',
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => handleSubmit(),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          onPressed: () => handleSubmit(),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
