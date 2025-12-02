import 'package:flutter/material.dart';
import 'package:todolist/data/init_hive.dart';
import 'package:todolist/provider/icons_repo.dart';
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
