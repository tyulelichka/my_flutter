import 'package:flutter/material.dart';

import 'package:todolist/data/initHive.dart';
import 'package:todolist/screen/toDoCategoryScreen.dart';

void main() async {
  await initHive();
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
