import 'package:hive/hive.dart';

part 'toDoList.g.dart';

@HiveType(typeId: 1)
class ToDoList extends HiveObject {
  @HiveField(0)
  String nameTask;

  @HiveField(1)
   bool taskCompleted;
  @HiveField(2)
  final String categoryNames;
  @HiveField(3)
  Function(bool)? onChanged;

  ToDoList({
    required this.nameTask,
    required this.taskCompleted,
    required this.categoryNames,
    this.onChanged,
  });

 
}
