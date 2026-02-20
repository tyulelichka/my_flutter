import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:uuid/uuid.dart';

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

  void addCategory({required String name, required String icon}) {
    final uuid = Uuid();
    categoryBox.add(
      ToDoCategory(categoryId: uuid.v4(), name: name, iconName: icon),
    );
    notifyListeners();
  }

  void createDefaultCategory() {
    final uuid = const Uuid();
    final exists = categoryBox.values.any(
      (category) => category.name == AppConstantsString.defaultCategoryName,
    );

    if (!exists) {
      categoryBox.add(
        ToDoCategory(
          categoryId: uuid.v4(),
          name: AppConstantsString.defaultCategoryName,
          iconName: 'all',
          isDefault: true,
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
    if (category.isDefault) return false;

    final defaultCategory = categoryBox.values.firstWhere(
      (value) => value.isDefault,
    );

    for (final task in taskBox.values) {
      if (task.idCategory == category.categoryId) {
        task.idCategory = defaultCategory.categoryId;
        task.save();
      }
    }

    category.delete();
    notifyListeners();
    return true;
  }

  int countTasks(String categoryId) {
    return taskBox.values
        .where(
          (task) => task.idCategory == categoryId && task.completed == false,
        )
        .length;
  }
}
