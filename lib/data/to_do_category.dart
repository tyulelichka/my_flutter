  import 'package:hive/hive.dart';

  part 'to_do_category.g.dart';

  @HiveType(typeId: 0)
  class ToDoCategory extends HiveObject {
    @HiveField(0)
    String categoryId;

    @HiveField(1)
    String name;

    @HiveField(2)
    String iconName;
    @HiveField(3)
    final bool isDefault;

    ToDoCategory({
      required this.categoryId,
      required this.name,
      required this.iconName,
      this.isDefault = false,
    });
  }
