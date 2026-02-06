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
    categoryBox.listenable().addListener(() {
      notifyListeners();
    });
  }
  List<ToDoCategory> get categories => categoryBox.values.toList();

  void addCategory({
    required String id,
    required String name,
    required String icon,
  }) {
    categoryBox.add(ToDoCategory(id: id, name: name, iconName: icon));
    notifyListeners();
  }

  void createDefaultCategory() {
    final exists = categoryBox.values.any(
      (category) => category.name == AppConstantsString.defaultCategoryName,
    );

    if (!exists) {
      categoryBox.add(
        ToDoCategory(
          id: 'default',
          name: AppConstantsString.defaultCategoryName,
          iconName: 'all',
        ),
      );
    }
  }

  void renameCategory(ToDoCategory category, String newName, String newIcon) {
    category.name = newName;
    category.iconName = newIcon;
    category.save();
    notifyListeners();
  }

  bool deleteCategory(ToDoCategory category) {
    if (category.id == 'default') return false;

    for (final task in taskBox.values) {
      if (task.idCategory == category.id) {
        task.idCategory = 'default';
        task.save();
      }
    }

    category.delete();
    notifyListeners();
    return true;
  }

  int countForCategory(String categoryId) {
    return taskBox.values
        .where(
          (task) => task.idCategory == categoryId && task.completed == false,
        )
        .length;
  }
}
