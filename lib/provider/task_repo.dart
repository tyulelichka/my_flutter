import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_list.dart';

class ToDoTaskRepository extends ChangeNotifier {
  ToDoTaskRepository();
  final List<ToDoTask> filterTask = [];
  List<ToDoTask> get tasks => List.unmodifiable(filterTask);
  static Box<ToDoTask> listTasksBox = Hive.box<ToDoTask>(
    AppConstants.toDoTaskBoxName,
  );

  void loadTasks(String categoryName) {
    filterTask
      ..clear()
      ..addAll(
        listTasksBox.values.where((task) => task.nameCategory == categoryName),
      );
    sortTask();
    notifyListeners();
  }

  void sortTask() {
    filterTask.sort((a, b) {
      final intA = a.favorites ? 1 : 0;
      final intB = b.favorites ? 1 : 0;
      return intB - intA;
    });
  }

  void updateFavorites(int index, bool value) {
    final task = filterTask[index];
    task.favorites = value;
    task.save();
    sortTask();
    notifyListeners();
  }

  void checkChange(bool? value, int index) {
    final task = filterTask[index];
    task.taskCompleted = value ?? false;
    task.save();
    notifyListeners();
  }

  void deleteTask(int index) {
    filterTask[index].delete();
    filterTask.removeAt(index);
    notifyListeners();
  }

  void addItemTask(ToDoTask task) {
    filterTask.add(task);
    listTasksBox.add(task);
    sortTask();
    notifyListeners();
  }
}
