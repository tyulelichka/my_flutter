import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/provider/task_repo.dart';
import 'package:todolist/widgets/add_task.dart';
import 'package:todolist/widgets/task.dart';

class ToDoTaskScreen extends StatelessWidget {
  const ToDoTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ToDoTaskRepository>();
    final tasks = repo.tasks;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(repo.categoryName),
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
              taskCompleted: item.taskCompleted,
              categoryName: item.nameCategory,
              isFavorite: item.favorites,
              onStateChanged: (v) => repo.checkChange(v, index),
              updatestate: (v) => repo.updateFavorites(index, v ?? false),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final controller = TextEditingController();
          showDialog(
            context: context,
            builder: (_) => AddElement(
              taskController: controller,
              addName: 'task',
              create: () {
                repo.addItemTask(
                  ToDoTask(
                    nameTask: controller.text,
                    taskCompleted: false,
                    nameCategory: repo.categoryName,
                    favorites: false,
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
