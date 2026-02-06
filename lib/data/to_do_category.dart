import 'package:hive/hive.dart';

part 'to_do_category.g.dart';

@HiveType(typeId: 0)
class ToDoCategory extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String iconName;

  ToDoCategory({required this.id, required this.name, required this.iconName});
}
