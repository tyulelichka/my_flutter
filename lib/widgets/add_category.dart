import 'package:flutter/material.dart';
import 'package:todolist/data/icons.dart';

class AddCategoryElement extends StatelessWidget {
  final TextEditingController inputName;
  final String initialIcon = 'all';
  final Function onAdd;

  const AddCategoryElement({
    super.key,
    required this.inputName,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    String selectedIcon = initialIcon;
    void handleSubmit() {
      String text = inputName.text.trim();
      if (text.isNotEmpty) {
        onAdd(text, selectedIcon);
        inputName.clear();
        Navigator.of(context).pop(true);
      }
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text('New category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: inputName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input name category',
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => handleSubmit(),
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
              onPressed: () => handleSubmit(),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
