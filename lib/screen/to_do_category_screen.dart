import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_category.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/screen/to_do_task_screen.dart';
import 'package:todolist/widgets/add_category.dart';
import 'package:todolist/widgets/category.dart';
import 'package:todolist/widgets/update_category.dart';

class ToDoCategoryScreen extends StatefulWidget {
  const ToDoCategoryScreen({super.key});

  @override
  State<ToDoCategoryScreen> createState() => CategoryScreen();
}

class CategoryScreen extends State<ToDoCategoryScreen> {
  final TextEditingController _nameCategory = TextEditingController();
  final TextEditingController _updateCategory = TextEditingController();
  final Box<ToDoCategory> listBox = Hive.box<ToDoCategory>(
    AppConstants.toDoCategoryBoxName,
  );

  @override
  void initState() {
    super.initState();
  }

  void _addCategory(String categoryName, String nameIcon) {
    setState(() {
      final newList = ToDoCategory(name: categoryName, nameIcon: nameIcon);
      listBox.add(newList);
    });
  }

  int countForCategory(String categoryName) {
    final listTasksBox = Hive.box<ToDoTask>(AppConstants.toDoListBoxName);
    return listTasksBox.values
        .where((task) => task.nameCategory == categoryName)
        .length;
  }

  Future<void> openCategory(ToDoCategory listBox) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToDoTaskScreen(
          categoryName: listBox.name,
          countTask: countForCategory(listBox.name),
        ),
      ),
    );

    if (updated == true) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _nameCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do Category'),
        backgroundColor: Colors.purple[200],
      ),
      backgroundColor: Colors.purple[50],
      body: ListView.builder(
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        itemCount: listBox.length,
        itemBuilder: (context, index) {
          final item = listBox.getAt(index);
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Slidable(
              key: ValueKey(item!.name),
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      _updateCategory.text = item.name;
                      showDialog(
                        context: context,
                        builder: (context) => UpdateElement(
                          addName: 'category',
                          inputName: _updateCategory,
                          initialIcon: item.nameIcon,
                          onUpdate: (newName, newIcon) {
                            setState(() {
                              item.rename(newName, newIcon);
                              item.save();
                            });
                          },
                        ),
                      );
                    },
                    icon: Icons.edit,
                    backgroundColor: const Color.fromARGB(255, 143, 244, 153),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        listBox.deleteAt(index);
                      });
                    },
                    icon: Icons.delete_outline,
                    backgroundColor: const Color.fromARGB(255, 252, 102, 91),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => openCategory(item),
                child: CardWidgets(
                  category: item,
                  nameIcon: item.nameIcon,
                  countTask: countForCategory(item.name),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 188, 60, 211),
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,

            builder: (context) => AddCategoryElement(
              inputName: _nameCategory,
              onAdd: (text, value) {
                _addCategory(text, value);
              },
            ),
          );
        },
      ),
    );
  }
}
