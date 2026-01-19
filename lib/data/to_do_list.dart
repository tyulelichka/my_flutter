import 'package:hive/hive.dart';

part 'to_do_list.g.dart';

@HiveType(typeId: 1)
class ToDoTask extends HiveObject {
  @HiveField(0)
  String nameTask;

  @HiveField(1)
  bool completed;

  @HiveField(2)
  String nameCategory;
  @HiveField(3)
  bool isFavorite;

  ToDoTask({
    required this.nameTask,
    required this.completed,
    required this.nameCategory,
    required this.isFavorite,
  });
}