import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/init_hive.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/provider/category_repo.dart';
import 'package:todolist/provider/icons_repo.dart';
import 'package:todolist/provider/task_repo.dart';
import 'package:todolist/screen/to_do_category_screen.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/icons_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => IconsProvider(IconsRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => ToDoCategoriesRepository(
            Hive.box<ToDoCategory>(AppConstantsString.toDoCategoryBoxName),
            Hive.box<ToDoTask>(AppConstantsString.toDoTaskBoxName),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ToDoTaskRepository(
            Hive.box<ToDoTask>(AppConstantsString.toDoTaskBoxName),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
