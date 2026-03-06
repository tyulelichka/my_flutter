import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/repeat_type.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/provider/category_repo.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ToDoCategoryAdapter());
  Hive.registerAdapter(ToDoTaskAdapter());
  Hive.registerAdapter(RepeatTypeAdapter());

  final categoryBox = await Hive.openBox<ToDoCategory>(
    AppConstantsString.toDoCategoryBoxName,
  );
  final taskBox = await Hive.openBox<ToDoTask>(
    AppConstantsString.toDoTaskBoxName,
  );
  
  final categoriesRepo = ToDoCategoriesRepository(categoryBox, taskBox);
  categoriesRepo.createDefaultCategory();
}
