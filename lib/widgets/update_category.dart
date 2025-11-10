import 'package:flutter/material.dart';
import 'package:todolist/data/icons.dart';

class UpdateElement extends StatelessWidget {
  final TextEditingController inputName;
  final String addName;
  final String initialIcon;
  final void Function(String newName, String newIcon) onUpdate;

  const UpdateElement({
    super.key,
    required this.addName,
    required this.inputName,
    required this.initialIcon,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    String selectedIcon = initialIcon;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text('Update $addName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: inputName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input new name $addName',
                ),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: selectedIcon,
                isExpanded: true,
                items: IconsMap.nameIcon.keys.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(IconsMap.getIcon(value)),
                        const SizedBox(width: 10),
                        Text(value),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedIcon = newValue!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String text = inputName.text.trim();
                if (text.isNotEmpty) {
                  onUpdate(text, selectedIcon);
                  Navigator.of(context).pop(true);
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
