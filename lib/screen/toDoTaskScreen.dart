import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/data/toDoList.dart';
import 'package:todolist/data/appConstants.dart';
import 'package:todolist/widgets/addElement.dart';

class ToDoTaskScreen extends StatefulWidget {
  final String categoryName;
  final int countTask;
  const ToDoTaskScreen({
    super.key,
    required this.categoryName,
    required this.countTask,
  });

  @override
  State<ToDoTaskScreen> createState() => TaskScreen();
}

class TaskScreen extends State<ToDoTaskScreen> {
  final List filterTask = [];
  late Box<ToDoTask> listTasksBox;

  final TextEditingController _myController = TextEditingController();

  void addFilterTask() {
    setState(() {
      filterTask.addAll(
        listTasksBox.values.where(
          (task) => task.nameCategory == widget.categoryName,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      listTasksBox = Hive.box<ToDoTask>(AppConstants.toDoListBoxName);
      addFilterTask();
    });
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  void addSingleTask(ToDoTask task) {
    if (task.nameCategory == widget.categoryName) {
      setState(() {
        filterTask.add(task);
      });
    }
  }

  void _addItemTask(String nameTask, String catName) {
    setState(() {
      final newTask = ToDoTask(
        nameTask: nameTask,
        taskCompleted: false,
        nameCategory: catName,
      );
      listTasksBox.add(newTask);
      addSingleTask(newTask);
    });
  }

  void checkChange(bool? value, int index) {
    setState(() {
      final task = filterTask[index];
      task.taskCompleted = value ?? false;
      task.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.purple[200],
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      backgroundColor: Colors.purple[50],
      body: ListView.separated(
        itemCount: filterTask.length,
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        itemBuilder: (context, index) {
          final item = filterTask[index];
          return Slidable(
            key: ValueKey(item.nameTask),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      item.delete();
                      setState(() {
                        filterTask.removeAt(index);
                      });
                    });
                  },
                  icon: Icons.delete_outline,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            child: TaskCard(
              nameTask: item.nameTask,
              taskCompleted: item.taskCompleted,
              categoryName: item.nameCategory,
              onChanged: (value) => checkChange(value, index),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 188, 60, 211),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddElement(
              inputName: _myController,
              addName: 'task',
              create: () {
                _addItemTask(_myController.text, widget.categoryName);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String nameTask;
  final bool taskCompleted;
  final String categoryName;
  Function(bool?) onChanged;

  TaskCard({
    super.key,
    required this.nameTask,
    required this.taskCompleted,
    required this.categoryName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
