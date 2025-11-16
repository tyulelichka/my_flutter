import 'package:hive/hive.dart';

part 'to_do_list.g.dart';

@HiveType(typeId: 1)
class ToDoTask extends HiveObject {
  @HiveField(0)
  final String nameTask;

  @HiveField(1)
   bool? taskCompleted;

  @HiveField(2)
  String nameCategory;
  @HiveField(3)
  bool favorites;

  ToDoTask({
    required this.nameTask,
    required this.taskCompleted,
    required this.nameCategory,
    required this.favorites,
  });
}
