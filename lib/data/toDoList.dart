import 'package:hive/hive.dart';

part 'toDoList.g.dart';

@HiveType(typeId: 1)
class ToDoTask extends HiveObject {
  @HiveField(0)
  String nameTask;

  @HiveField(1)
  bool? taskCompleted;

  @HiveField(2)
  final String nameCategory;

  ToDoTask({
    required this.nameTask,
    required this.taskCompleted,
    required this.nameCategory,
  });
}
