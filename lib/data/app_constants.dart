import 'package:hive/hive.dart';
import 'package:todolist/data/to_do_list.dart';

abstract class AppConstantsString {
  static const toDoTaskBoxName = 'to_do_task';
  static const toDoCategoryBoxName = 'to_do_category';
  static const initialIcon = 'all';
}
abstract class AppConstantsBox {
  static Box<ToDoTask> listTasksBox = Hive.box<ToDoTask>(
    AppConstantsString.toDoTaskBoxName,
  );
}