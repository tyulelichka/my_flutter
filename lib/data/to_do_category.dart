import 'package:hive/hive.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_list.dart';

part 'to_do_category.g.dart';

@HiveType(typeId: 0)
class ToDoCategory extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String nameIcon;

  ToDoCategory({required this.name, required this.nameIcon});
  void update(String newName, String icon) {
    name = newName;
    nameIcon = icon;
    save();
  }
  void rename(String newName, String newIcon) {
    final oldName = name;
    update(newName, newIcon);
    save();

    final taskBox = Hive.box<ToDoTask>(AppConstants.toDoListBoxName);
    for (var task in taskBox.values) {
      if (task.nameCategory == oldName) {
        task.nameCategory = newName;
        task.save();
      }
    }
  }
}
