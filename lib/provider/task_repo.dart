import 'package:flutter/material.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_list.dart';

class ToDoTaskRepository extends ChangeNotifier {
  ToDoTaskRepository();
  final List<ToDoTask> _filteredTask = [];
  List<ToDoTask> get tasks => List.unmodifiable(_filteredTask);

  void loadTasks(String categoryName) {
    _filteredTask
      ..clear()
      ..addAll(
        AppConstants.listTasksBox.values.where(
          (task) => task.nameCategory == categoryName,
        ),
      );
    sortTask();
    notifyListeners();
  }

  void sortTask() {
    _filteredTask.sort((a, b) {
      final intA = a.favorites ? 1 : 0;
      final intB = b.favorites ? 1 : 0;
      return intB - intA;
    });
  }

  void updateFavorites(int index, bool value) {
    final task = _filteredTask[index];
    task.favorites = value;
    task.save();
    sortTask();
    notifyListeners();
  }

  void checkChange(bool? value, int index) {
    final task = _filteredTask[index];
    task.taskCompleted = value ?? false;
    task.save();
    notifyListeners();
  }

  void deleteTask(int index) {
    _filteredTask[index].delete();
    _filteredTask.removeAt(index);
    notifyListeners();
  }

  void addItemTask(ToDoTask task) {
    _filteredTask.add(task);
    AppConstants.listTasksBox.add(task);
    sortTask();
    notifyListeners();
  }
}