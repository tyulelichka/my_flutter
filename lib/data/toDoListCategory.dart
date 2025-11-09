import 'package:hive/hive.dart';

part 'toDoListCategory.g.dart';

@HiveType(typeId: 0)
class ToDoCategory extends HiveObject {
  @HiveField(0)
  String name;

  ToDoCategory({required this.name});
}
