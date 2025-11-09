import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/toDoList.dart';
import 'package:todolist/data/appConstants.dart';
import 'package:todolist/data/toDoListCategory.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ToDoCategoryAdapter());
  Hive.registerAdapter(ToDoTaskAdapter());

  await Hive.openBox<ToDoCategory>(AppConstants.toDoCategoryBoxName);
  await Hive.openBox<ToDoTask>(AppConstants.toDoListBoxName);
  await Hive.box<ToDoCategory>(AppConstants.toDoCategoryBoxName).clear();
  await Hive.box<ToDoTask>(AppConstants.toDoListBoxName).clear();
}
