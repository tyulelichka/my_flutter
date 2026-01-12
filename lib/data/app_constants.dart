import 'package:hive/hive.dart';
import 'package:todolist/data/to_do_list.dart';

abstract class AppConstants {
  static const toDoTaskBoxName = 'to_do_task';
  static const toDoCategoryBoxName = 'to_do_category';
  static const initialIcon = 'all';
  static Box<ToDoTask> listTasksBox = Hive.box<ToDoTask>(
    AppConstants.toDoTaskBoxName,
  );
}