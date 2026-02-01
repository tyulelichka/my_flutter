import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/to_do_list.dart';

class ToDoTaskRepository extends ChangeNotifier {
  final Box<ToDoTask> listTasksBox;
  final List<ToDoTask> _filteredTask = [];
  ToDoTaskRepository(this.listTasksBox);
  List<ToDoTask> get tasks => List.unmodifiable(_filteredTask);

  void loadTasks(String categoryName) {
    _filteredTask
      ..clear()
      ..addAll(
        listTasksBox.values.where((task) => task.nameCategory == categoryName),
      );
    sortTask();
    notifyListeners();
  }

  void sortTask() {
    _filteredTask.sort((a, b) {
      final intA = a.isFavorite ? 1 : 0;
      final intB = b.isFavorite ? 1 : 0;
      return intB - intA;
    });
  }

  void updateFavorites(String id, bool value) {
    final task = _filteredTask.firstWhere((value) => value.id == id);
    task.isFavorite = value;
    task.save();

    sortTask();
    notifyListeners();
  }

  void checkChange(bool? value, String id) {
    final task = _filteredTask.firstWhere((value) => value.id == id);
    task.completed = value ?? false;
    task.save();
    notifyListeners();
  }

  void deleteTask(String id) {
    final task = _filteredTask.indexWhere((value) => value.id == id);
    _filteredTask[task].delete();
    _filteredTask.removeAt(task);

    notifyListeners();
  }

  void addItemTask(ToDoTask task) {
    _filteredTask.add(task);
    listTasksBox.add(task);
    sortTask();
    notifyListeners();
  }
}
