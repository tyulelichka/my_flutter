import 'package:hive/hive.dart';

part 'to_do_list.g.dart';

@HiveType(typeId: 1)
class ToDoTask extends HiveObject {
  @HiveField(0)
  String taskId;

  @HiveField(1)
  String nameTask;

  @HiveField(2)
  bool completed;

  @HiveField(3)
  String idCategory;

  @HiveField(4)
  bool isFavorite;

  ToDoTask({
    required this.taskId,
    required this.nameTask,
    required this.completed,
    required this.idCategory,
    required this.isFavorite,
  });
}
