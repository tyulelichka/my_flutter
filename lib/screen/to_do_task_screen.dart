import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/provider/task_repo.dart';
import 'package:todolist/widgets/add_task.dart';
import 'package:todolist/widgets/task.dart';

class ToDoTaskScreen extends StatelessWidget {
  final String categoryName;
  const ToDoTaskScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ToDoTaskRepository>();
    final tasks = repo.tasks;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.purple[200],
      ),
      backgroundColor: Colors.purple[50],
      body: ListView.separated(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final item = tasks[index];
          return Slidable(
            key: ValueKey(item.key),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => repo.deleteTask(index),
                  icon: Icons.delete_outline,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            child: TaskCard(
              nameTask: item.nameTask,
              taskCompleted: item.completed,
              categoryName: item.nameCategory,
              isFavorite: item.isFavorite,
              onStateChanged: (value) => repo.checkChange(value, index),
              updatestate: (value) =>
                  repo.updateFavorites(index, value ?? false),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddElement(
              addName: 'task',
              create: (context) {
                repo.addItemTask(
                  ToDoTask(
                    nameTask: context,
                    completed: false,
                    nameCategory: categoryName,
                    isFavorite: false,
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
