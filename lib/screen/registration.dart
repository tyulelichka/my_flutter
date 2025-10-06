import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:todolist/data/database.dart';

class ZeroScreen extends StatefulWidget {
  const ZeroScreen({super.key});

  @override
  State<ZeroScreen> createState() => Authorization();
}

class Authorization extends State<ZeroScreen> {
  Authorization();

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login or registration'),
        backgroundColor: Colors.purple[200],
      ),
      backgroundColor: Colors.purple[50],
      body: Padding(
        padding: EdgeInsetsGeometry.only(top: 200, left: 20, right: 20),
        child: Container(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email or username',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Login'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don`t you have account?'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Registration'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
