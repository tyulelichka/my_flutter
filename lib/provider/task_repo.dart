import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/repeat_type.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';

class ToDoTaskRepository extends ChangeNotifier {
  final Box<ToDoTask> listTasksBox;
  final List<ToDoTask> _filteredTask = [];
  final Box<ToDoCategory> categoryBox;
  ToDoTaskRepository(this.listTasksBox, this.categoryBox);

  List<ToDoCategory> get categories => categoryBox.values.toList();
  List<ToDoTask> get tasks => List.unmodifiable(_filteredTask);

  void loadTasks({required String categoryId}) {
    _filteredTask
      ..clear()
      ..addAll(
        listTasksBox.values.where((task) => task.idCategory == categoryId),
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

  void updateFavorites(String taskId, bool value) {
    final task = _filteredTask.firstWhere((value) => value.taskId == taskId);
    task.isFavorite = value;
    task.save();
    sortTask();
    notifyListeners();
  }

  void checkChange(String taskId, bool? value, BuildContext context) {
    final taskBox = Hive.box<ToDoTask>(AppConstantsString.toDoTaskBoxName);
    final task = taskBox.values.firstWhere((value) => value.taskId == taskId);

    task.completed = value ?? false;
    task.save();

    if ((value ?? false) && task.repeat != RepeatType.none) {
      DateTime newDate;

      switch (task.repeat) {
        case RepeatType.daily:
          newDate = task.date.add(const Duration(days: 1));
          break;
        case RepeatType.weekly:
          newDate = task.date.add(const Duration(days: 7));
          break;
        case RepeatType.monthly:
          newDate = DateTime(
            task.date.year,
            task.date.month + 1,
            task.date.day,
          );
          break;
        case RepeatType.none:
          newDate = task.date;
          break;
      }
      final newTask = ToDoTask(
        taskId: UniqueKey().toString(),
        nameTask: task.nameTask,
        date: newDate,
        repeat: task.repeat,
        completed: false,
        idCategory: task.idCategory,
        isFavorite: false,
      );

      taskBox.add(newTask);
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task "${task.nameTask}" completed'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green[400],
          ),
        );
      }
    }
    notifyListeners();
  }

  void deleteTask(String taskId) {
    final task = _filteredTask.indexWhere((value) => value.taskId == taskId);
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

  void moveTaskToCategory({
    required String taskId,
    required String newIdCategory,
  }) {
    final task = listTasksBox.values.firstWhere(
      (value) => value.taskId == taskId,
    );
    task.idCategory = newIdCategory;
    task.save();

    _filteredTask.removeWhere((value) => value.taskId == taskId);

    notifyListeners();
  }

  void updateRepeatType({
    required String taskId,
    required RepeatType repeatType,
  }) {
    final task = tasks.firstWhere((value) => value.taskId == taskId);
    task.repeat = repeatType;
    task.save();
  }
}
