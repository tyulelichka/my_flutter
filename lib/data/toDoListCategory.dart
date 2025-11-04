import 'package:hive/hive.dart';

part 'toDoListCategory.g.dart';

@HiveType(typeId: 0)
class ToDoListCategory extends HiveObject {
  @HiveField(0)
  String nameCategory;

  ToDoListCategory({required this.nameCategory});
}
