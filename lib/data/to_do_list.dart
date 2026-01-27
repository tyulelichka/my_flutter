import 'package:hive/hive.dart';

part 'to_do_list.g.dart';

@HiveType(typeId: 1)
class ToDoTask extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nameTask;

  @HiveField(2)
  bool completed;

  @HiveField(3)
  String nameCategory;

  @HiveField(4)
  bool isFavorite;

  ToDoTask({
    required this.id,
    required this.nameTask,
    required this.completed,
    required this.nameCategory,
    required this.isFavorite,
  });
}
