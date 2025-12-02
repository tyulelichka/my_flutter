import 'package:hive/hive.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';

class ToDoTaskRepository {
 
  ToDoTaskRepository();
   List filterTask = [];


  void sortTask(List tasks) {
    filterTask == tasks;
    filterTask.sort((a, b) {
      final intA = a.favorites ? 1 : 0;
      final intB = b.favorites ? 1 : 0;
      return intB - intA;
    });
  }

  void updateFavorites(bool? name, int index, List tasks) {
 //  tasks == filterTask;
     filterTask = tasks;
    final task = filterTask[index];
    task.favorites = name ?? false;
    task.save();
    sortTask(tasks);
  }
}
