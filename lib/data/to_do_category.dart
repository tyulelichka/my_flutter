import 'package:hive/hive.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_list.dart';

part 'to_do_category.g.dart';

@HiveType(typeId: 0)
class ToDoCategory extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String iconName;

  ToDoCategory({required this.name, required this.iconName});
  
}

class ToDoCategoryUpdate {
  final ToDoCategory toDoCategory;
  ToDoCategoryUpdate(this.toDoCategory);

  void update(String newName, String icon) {
    toDoCategory.name = newName;
    toDoCategory.iconName = icon;
    toDoCategory.save();
  }

  void rename(String newName, String newIcon) {
    final oldName = toDoCategory.name;
    update(newName, newIcon);
   toDoCategory.save();

    final taskBox = Hive.box<ToDoTask>(AppConstants.toDoTaskBoxName);
    for (var task in taskBox.values) {
      if (task.nameCategory == oldName) {
        task.nameCategory = newName;
        task.save();
      }
    }
  }

}