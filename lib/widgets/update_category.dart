import 'package:flutter/material.dart';
import 'package:todolist/provider/icons_repo.dart';

class UpdateCategory extends StatefulWidget {
  final String initialIcon;
  final void Function(String newName, String newIcon) onUpdate;
  final String initialName;

  const UpdateCategory({
    super.key,
    required this.initialIcon,
    required this.onUpdate,
    required this.initialName,
  });

  @override
  State<UpdateCategory> createState() => UpdateCategoryState();
}

class UpdateCategoryState extends State<UpdateCategory> {
  late final TextEditingController newName;

  @override
  void initState() {
    super.initState();
    newName = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    newName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedIcon = widget.initialIcon;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text('Update category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input new name',
                ),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: selectedIcon,
                isExpanded: true,
                items: IconsRepositoryImpl.nameIcon.keys.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(IconsRepository.getIcon(value)),
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
                String text = newName.text.trim();
                if (text.isNotEmpty) {
                  widget.onUpdate(text, selectedIcon);
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
