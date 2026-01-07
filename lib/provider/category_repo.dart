import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/provider/task_repo.dart';
import 'package:todolist/screen/to_do_task_screen.dart';

class ToDoCategoriesRepository extends ChangeNotifier {
  final Box<ToDoCategory> categoryBox;
  final Box<ToDoTask> taskBox;

  ToDoCategoriesRepository(this.categoryBox, this.taskBox) {
    taskBox.listenable().addListener(() {
      notifyListeners();
    });
  }
  List<ToDoCategory> get categories => categoryBox.values.toList();

  void addCategory(String name, String icon) {
    categoryBox.add(ToDoCategory(name: name, iconName: icon));
    notifyListeners();
  }

  void openCategory(BuildContext context, ToDoCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => ToDoTaskRepository(category.name),
          child: const ToDoTaskScreen(),
        ),
      ),
    );
  }

  void renameCategory(ToDoCategory category, String newName, String newIcon) {
    final oldName = category.name;
    category.name = newName;
    category.iconName = newIcon;
    category.save();

    for (final task in taskBox.values) {
      if (task.nameCategory == oldName) {
        task.nameCategory = newName;
        task.save();
      }
    }
    notifyListeners();
  }

  void deleteCategory(ToDoCategory category) {
    category.delete();

    for (final task in taskBox.values) {
      if (task.nameCategory == category.name) {
        task.delete();
      }
    }
    notifyListeners();
  }

  int countForCategory(String categoryName) {
    final listTasksBox = Hive.box<ToDoTask>(AppConstants.toDoTaskBoxName);
    return listTasksBox.values
        .where((task) => task.nameCategory == categoryName)
        .length;
  }
}
