import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screen/first_screen.dart';
import 'screen/registration.dart';

void main() async {
  await Hive.initFlutter();
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 140, 94, 220),
        ),
      ),
      home: ZeroScreen(),
    );
  }
}
