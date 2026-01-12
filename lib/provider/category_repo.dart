import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';

class ToDoCategoriesRepository extends ChangeNotifier {
  final Box<ToDoCategory> categoryBox;
  final Box<ToDoTask> taskBox;

  ToDoCategoriesRepository(this.categoryBox, this.taskBox) {
    taskBox.listenable().addListener(() {
      notifyListeners();
    });
  }
  List<ToDoCategory> get categories => categoryBox.values.toList();

  void addCategory({required String name, required String icon}) {
    categoryBox.add(ToDoCategory(name: name, iconName: icon));
    notifyListeners();
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
    notifyListeners();
  }

  int countForCategory(String categoryName) {
    final listTasksBox = Hive.box<ToDoTask>(AppConstantsString.toDoTaskBoxName);
    return listTasksBox.values
        .where((task) => task.nameCategory == categoryName)
        .length;
  }
}
