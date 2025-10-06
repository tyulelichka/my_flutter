import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TwoScreen extends StatefulWidget {
  final String categoryName;
  const TwoScreen({super.key, required this.categoryName});

  @override
  State<TwoScreen> createState() => _TwoScreenState();
}

class _TwoScreenState extends State<TwoScreen> {
  final myBox = Hive.box('mybox');
  ToDoDataBaseTask db = ToDoDataBaseTask();
  final List filterTask = [];
  final TextEditingController _myController = TextEditingController();

  bool _hasChanges = false; // <-- отслеживаем изменения

  @override
  void initState() {
    super.initState();
    if (myBox.get("ToDoListTask") == null) {
      db.createInitTask();
    } else {
      db.loadDataTask();
    }

    filterTask.clear();
    filterTask.addAll(db.ToDoTask.where((index) => index[2] == widget.categoryName));
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  void _addItemTask(String nameTask, String catName) {
    setState(() {
      db.ToDoTask.add([nameTask, false, catName]);
      _hasChanges = true;
      filterTask.clear();
      filterTask.addAll(db.ToDoTask.where((index) => index[2] == widget.categoryName));
      db.updateData();
    });
  }

  void _deleteItemTask(int index) {
    setState(() {
      var taskToRemove = filterTask[index];
      db.ToDoTask.remove(taskToRemove);
      _hasChanges = true;
      db.updateData();
      filterTask.clear();
      filterTask.addAll(db.ToDoTask.where((index) => index[2] == widget.categoryName));
    });
  }

  void checkChange(bool? value, int index) {
    setState(() {
      db.ToDoTask[index][1] = !db.ToDoTask[index][1];
      _hasChanges = true;
      db.updateData();
    });
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New task'),
          content: TextField(
            controller: _myController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input new task',
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
                String textTasks = _myController.text.trim();
                if (textTasks.isNotEmpty) {
                  _addItemTask(textTasks, widget.categoryName);
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

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _hasChanges);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          backgroundColor: Colors.purple[200],
        ),
        backgroundColor: Colors.purple[50],
        body: ListView.separated(
          itemCount: filterTask.length,
          padding: EdgeInsets.only(top: 12, bottom: MediaQuery.of(context).padding.bottom),
          itemBuilder: (context, index) {
            return Slidable(
              key: Key(filterTask[index][0]),
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => _deleteItemTask(index),
                    icon: Icons.delete_outline,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TaskWidgets(
                  nameTask: filterTask[index][0],
                  taskCompleted: db.ToDoTask[index][1],
                  categoryNames: db.ToDoTask[index][2],
                  onChanged: (value) => checkChange(value, index),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 188, 60, 211),
          child: const Icon(Icons.add),
          onPressed: createTask,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskWidgets extends StatelessWidget {
  final String nameTask;
  final bool taskCompleted;
  final String categoryNames;
  Function(bool?) onChanged;

  TaskWidgets({
    super.key,
    required this.nameTask,
    required this.taskCompleted,
    required this.categoryNames,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.purple[100],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          children: [
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),
            Text(
              nameTask,
              style: TextStyle(
                fontSize: 18.0,
                decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
