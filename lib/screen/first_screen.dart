import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/screen/categoryList.dart';

class FirstScreen extends StatefulWidget {
  final String? categoryName;
  FirstScreen({super.key, this.categoryName});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  ToDoDataBaseTask dbTask = ToDoDataBaseTask();

  final TextEditingController _myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (myBox.get("ToDoListTask") == null) {
      dbTask.createInitTask();
    } else {
      dbTask.loadDataTask();
    }

    if (myBox.get("ToDoList") == null) {
      db.createInit();
    } else {
      db.loadData();
    }

    updateCategoryTasks();
  }

  void updateCategoryTasks() {
    for (var category in db.TodoBase) {
      String categoryName = category['name'];
      final count = dbTask.ToDoTask.where(
        (task) => task[2] == categoryName,
      ).length;
      category['tasks'] = count;
    }
    db.updateData();
  }

  void _addCategory(String enteredText) {
    setState(() {
      db.TodoBase.add({'name': enteredText, 'tasks': 0});
      db.updateData();
    });
  }

  void createCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New category'),
          content: TextField(
            controller: _myController,
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
                String textCategory = _myController.text;
                if (textCategory.isNotEmpty) {
                  _addCategory(textCategory);
                }
                _myController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> openCategory(String categoryName) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TwoScreen(categoryName: categoryName),
      ),
    );

    if (updated == true) {
      setState(() {
        updateCategoryTasks();
      });
    }
  }

  @override
  void dispose() {
    _myController.dispose();
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
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        
        children: db.TodoBase.map(
          (item) => Slidable(
            key: ValueKey(item['name']),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      db.TodoBase.remove(item);
                      db.updateData();
                    });
                  },
                  icon: Icons.delete_outline,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => openCategory(item['name']),
              child: SizedBox.expand(
                child: CardWidgets(
                  categoryName: item['name'],
                  index: item['tasks'],
                ),
              ),
            ),
          ),
        ).toList(),
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
  final String categoryName;
  final int? index;

  const CardWidgets({super.key, required this.categoryName, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.purple[100],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.all_inbox, size: 35),
          const SizedBox(height: 25),
          Text(categoryName, style: const TextStyle(fontSize: 21.0)),
          Text('${index ?? 0} tasks'),
        ],
      ),
    );
  }
}