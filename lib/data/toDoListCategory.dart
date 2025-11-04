import 'package:hive/hive.dart';

part 'toDoListCategory.g.dart';

@HiveType(typeId: 0)
class ToDoListCategory extends HiveObject {
  @HiveField(0)
  String nameCategory;

  @HiveField(1)
  int index;

  ToDoListCategory({required this.nameCategory, required this.index});
}
