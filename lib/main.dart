import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/appConstants.dart';
import 'package:todolist/data/toDoList.dart';
import 'package:todolist/data/toDoListCategory.dart';
import 'package:todolist/screen/toDoCategoryScreen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoListCategoryAdapter());
  Hive.registerAdapter(ToDoListAdapter());
  await Hive.openBox<ToDoListCategory>(AppConstants.toDoCategoryBoxName);
  await Hive.openBox<ToDoList>(AppConstants.toDoListBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 140, 94, 220),
        ),
      ),
      home: ToDoCategoryScreen(),
    );
  }
}
