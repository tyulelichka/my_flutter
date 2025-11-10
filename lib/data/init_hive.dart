import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ToDoCategoryAdapter());
  Hive.registerAdapter(ToDoTaskAdapter());

  await Hive.openBox<ToDoCategory>(AppConstants.toDoCategoryBoxName);
  await Hive.openBox<ToDoTask>(AppConstants.toDoListBoxName);
}
