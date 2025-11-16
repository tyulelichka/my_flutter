import 'package:flutter/material.dart';
import 'package:todolist/data/icons.dart';
import 'package:todolist/data/to_do_category.dart';

class CardWidgets extends StatelessWidget {
  final ToDoCategory category;
  final int countTask;
  final String nameIcon;
  
  const CardWidgets({
    super.key,
    required this.category,
    required this.countTask,
    required this.nameIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.purple[100],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 10.0),
              child: Icon(IconsMap.nameIcon[nameIcon], size: 32),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  category.name,
                  style: const TextStyle(fontSize: 21.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('$countTask tasks'),
            ),
          ],
        ),
      ),
    );
  }
}
