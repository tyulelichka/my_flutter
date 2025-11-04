import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/data/toDoList.dart';
import 'package:todolist/data/toDoListCategory.dart';
import 'package:todolist/screen/toDoSecondScreen.dart';

class ToDoFirstScreen extends StatefulWidget {
  const ToDoFirstScreen({super.key});

  @override
  State<ToDoFirstScreen> createState() => ToDoFirst();
}

class ToDoFirst extends State<ToDoFirstScreen> {
  final TextEditingController _nameCategory = TextEditingController();
  late Box<ToDoListCategory> listBox;
  final int indexNew = 0;
  @override
  void initState() {
    super.initState();
    listBox = Hive.box<ToDoListCategory>('todolist2');
  }

  void _addCategory(String enteredText) {
    setState(() {
      final newList = ToDoListCategory(nameCategory: enteredText, index: 0);
      listBox.add(newList);
    });
  }

  void createCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New category'),
          content: TextField(
            controller: _nameCategory,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input new category',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                String textCategory = _nameCategory.text;
                if (textCategory.isNotEmpty) {
                  _addCategory(textCategory);
                }
                _nameCategory.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  int countForCategory(String categoryName) {
    final listTasksBox = Hive.box<ToDoList>('todolist3');
    return listTasksBox.values
        .where((task) => task.categoryNames == categoryName)
        .length;
  }

  Future<void> openCategory(ToDoListCategory listBox) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToDoSecondScreen(
          categoryName: listBox.nameCategory,
          countTask: countForCategory(listBox.nameCategory),
        ),
      ),
    );

    if (updated == true) {
      setState(() {
      });
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
            key: ValueKey(item!.nameCategory),
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
                  indexCat: countForCategory(item.nameCategory),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 188, 60, 211),
        child: const Icon(Icons.add),
        onPressed: createCategory,
      ),
    );
  }
}

class CardWidgets extends StatelessWidget {
  final ToDoListCategory category;
  final int indexCat;
  const CardWidgets({
    super.key,
    required this.category,
    required this.indexCat,
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
              Text(
                category.nameCategory,

                style: const TextStyle(fontSize: 21.0),
              ),

              Text('${indexCat} tasks'),
            ],
          ),
        ),
      ),
    );
  }
}
