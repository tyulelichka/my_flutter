import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/data/appConstants.dart';
import 'package:todolist/data/toDoList.dart';
import 'package:todolist/data/toDoListCategory.dart';
import 'package:todolist/screen/toDoTaskScreen.dart';
import 'package:todolist/widgets/addElement.dart';

class ToDoCategoryScreen extends StatefulWidget {
  const ToDoCategoryScreen({super.key});

  @override
  State<ToDoCategoryScreen> createState() => CategoryScreen();
}

class CategoryScreen extends State<ToDoCategoryScreen> {
  final TextEditingController _nameCategory = TextEditingController();
  late Box<ToDoCategory> listBox;

  @override
  void initState() {
    super.initState();
    listBox = Hive.box<ToDoCategory>(AppConstants.toDoCategoryBoxName);
  }

  void _addCategory(String categoryName) {
    setState(() {
      final newList = ToDoCategory(name: categoryName);
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
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemCount: listBox.length,
        itemBuilder: (context, index) {
          final item = listBox.getAt(index);

          return Slidable(
            key: ValueKey(item!.name),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      listBox.deleteAt(index);
                    });
                  },
                  icon: Icons.delete_outline,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => openCategory(item),
              child: SizedBox.expand(
                child: CardWidgets(
                  category: item,
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
            builder: (context) => AddElement(
              inputName: _nameCategory,
              addName: 'category',

              create: () {
                _addCategory(_nameCategory.text);
              },
            ),
          );
        },
      ),
    );
  }
}

class CardWidgets extends StatelessWidget {
  final ToDoCategory category;
  final int countTask;
  const CardWidgets({
    super.key,
    required this.category,
    required this.countTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.purple[100],
        ),
        child: SizedBox(
          width: 200,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.all_inbox, size: 35),
              const SizedBox(height: 25),
              Text(category.name, style: const TextStyle(fontSize: 21.0)),

              Text('${countTask} tasks'),
            ],
          ),
        ),
      ),
    );
  }
}
