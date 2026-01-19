import 'package:flutter/material.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/provider/icons_provider.dart';

class AddCategoryElement extends StatefulWidget {
  final IconsProvider iconsProvider;
  final Function onAdd;

  const AddCategoryElement({
    super.key,
    required this.onAdd,
    required this.iconsProvider,
  });

  @override
  State<AddCategoryElement> createState() => _AddCategoryElementState();
}

class _AddCategoryElementState extends State<AddCategoryElement> {
  String selectedIcon = AppConstantsString.initialIcon;
  final TextEditingController categoryNameController = TextEditingController();

  void handleSubmit() {
    String text = categoryNameController.text.trim();
    if (text.isNotEmpty) {
      widget.onAdd(text, selectedIcon);
      categoryNameController.clear();
    }
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text('New category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input name category',
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: ((_) {
                  handleSubmit();
                  Navigator.of(context).pop(true);
                }),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: selectedIcon,
                isExpanded: true,
                items: widget.iconsProvider.allIcons.keys.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(widget.iconsProvider.getIcon(value)),
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
                handleSubmit();
                Navigator.of(context).pop(true);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
