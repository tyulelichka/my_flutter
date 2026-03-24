import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/repeat_type.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

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
        listTasksBox.values
            .where((task) => task.idCategory == categoryId)
            .toList(),
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
    notifyListeners();
  }

  void updateFavorites(String taskId, bool value) {
    final task = _filteredTask.firstWhere((value) => value.taskId == taskId);
    task.isFavorite = value;
    task.save();

    sortTask();
  }

  void checkChange(String taskId, bool? value, BuildContext context) {
    final taskBox = Hive.box<ToDoTask>(AppConstantsString.toDoTaskBoxName);
    final task = taskBox.values.firstWhereOrNull(
      (value) => value.taskId == taskId,
    );
    if (task == null) return;

    if (value == true) {
      task.completed = true;
      task.save();
    } else {
      task.completed = false;
      task.save();
    }

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
        default:
          newDate = task.date;
      }

      final newTask = ToDoTask(
        taskId: const Uuid().v4(),
        nameTask: task.nameTask,
        date: newDate,
        repeat: task.repeat,
        completed: false,
        idCategory: task.idCategory,
        isFavorite: task.isFavorite,
      );
      taskBox.add(newTask);
    }

    final repo = context.read<ToDoTaskRepository>();
    repo.loadTasks(categoryId: task.idCategory);
  }

  void deleteTask(String taskId) {
    final index = _filteredTask.indexWhere((value) => value.taskId == taskId);

    if (index != -1) {
      final task = _filteredTask[index];
      task.delete();
      _filteredTask.removeAt(index);
      notifyListeners();
    }
  }

  void addItemTask(ToDoTask task) {
    listTasksBox.add(task);
    loadTasks(categoryId: task.idCategory);
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

  String getDate({required String taskId}) {
    final task = tasks.firstWhere((value) => value.taskId == taskId);
    return DateFormat('dd.MM.yyyy').format(task.date);
  }

  void updateDeadline({required String taskId, required DateTime deadline}) {
    final task = tasks.firstWhere((value) => value.taskId == taskId);
    task.date = deadline;
    task.save();
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
