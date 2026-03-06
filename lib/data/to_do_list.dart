import 'package:hive/hive.dart';
import 'package:todolist/data/repeat_type.dart';

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

  @HiveField(5)
  RepeatType repeat;

  @HiveField(6)
  DateTime date;

  ToDoTask({
    required this.taskId,
    required this.nameTask,
    required this.completed,
    required this.idCategory,
    required this.isFavorite,
    this.repeat = RepeatType.none,
    required this.date,
  });
}
