import 'package:hive/hive.dart';


part 'to_do_category.g.dart';

@HiveType(typeId: 0)
class ToDoCategory extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String iconName;

  ToDoCategory({required this.name, required this.iconName});
  
}
