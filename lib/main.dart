import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/toDoList.dart';
import 'package:todolist/data/toDoListCategory.dart';
import 'package:todolist/screen/toDoFirst.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(ToDoListCategoryAdapter());
  await Hive.openBox<ToDoListCategory>('toDoList2');

  Hive.registerAdapter(ToDoListAdapter());
  await Hive.openBox<ToDoList>('toDoList3');
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
      home: ToDoFirstScreen(),
    );
  }
}
