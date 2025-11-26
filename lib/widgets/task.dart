import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String nameTask;
  final bool taskCompleted;
  final String categoryName;
  final Function(bool?) onStateChanged;
  final Function(bool?) updatestate;
  final bool isFavorite;

  const TaskCard({
    super.key,
    required this.nameTask,
    required this.taskCompleted,
    required this.categoryName,
    required this.onStateChanged,
    required this.isFavorite,
    required this.updatestate,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.purple[100],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onStateChanged,
                  activeColor: Colors.black,
                ),
                Text(
                  nameTask,
                  style: TextStyle(
                    fontSize: 18.0,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),

            IconButton(
              onPressed: () => updatestate(!isFavorite),
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}