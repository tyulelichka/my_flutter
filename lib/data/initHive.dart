import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/toDoList.dart';
import 'package:todolist/data/appConstants.dart';
import 'package:todolist/data/toDoListCategory.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ToDoCategoryAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ToDoTaskAdapter());
  }

  await Hive.openBox<ToDoCategory>(AppConstants.toDoCategoryBoxName);
  await Hive.openBox<ToDoTask>(AppConstants.toDoListBoxName);
}
