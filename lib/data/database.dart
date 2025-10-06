import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List<Map<String, dynamic>> TodoBase = [];

  final myBox = Hive.box('mybox');

  void createInit() {
    TodoBase = [
      {'name': 'All', 'tasks': 0},
    ];
  }

  void loadData() {
    final raw = myBox.get('ToDoList', defaultValue: []);
    TodoBase = (raw as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }

  void deleteCategory(String name) {
    TodoBase.removeWhere((item) => item['name'] == name);
    myBox.put('ToDoList', TodoBase);
  }

  void updateData() {
    myBox.put("ToDoList", TodoBase);
  }
}

class ToDoDataBaseTask {
  List ToDoTask = [];

  final myBox = Hive.box('mybox');

  void createInitTask() {
    ToDoTask = [
      ['name', false, 'all'],
    ];
  }

  void loadDataTask() {
    ToDoTask = myBox.get('ToDoListTask');
  }

  void deleteTask(int index) {
    ToDoTask.removeWhere((item) => item[index] == index);
    myBox.put('ToDoListTask', ToDoTask);
  }

  void updateData() {
    myBox.put("ToDoListTask", ToDoTask);
  }
}
