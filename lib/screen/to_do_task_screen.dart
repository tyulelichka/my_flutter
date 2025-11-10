import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/data/app_constants.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/widgets/add_task.dart';
import 'package:todolist/widgets/task.dart';

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
  // final List filterDoneTask = [];
  final Box<ToDoTask> listTasksBox = Hive.box<ToDoTask>(
    AppConstants.toDoListBoxName,
  );
  final TextEditingController _myController = TextEditingController();

  void addFilterTask() {
    setState(() {
      filterTask.addAll(
        listTasksBox.values.where(
          (task) =>
              task.nameCategory == widget.categoryName
              //  &&
              // task.taskCompleted == false,
        ),
      );
      // filterDoneTask.addAll(
      //   listTasksBox.values.where(
      //     (task) =>
      //         task.nameCategory == widget.categoryName &&
      //         task.taskCompleted == true,
      //   ),
      // );
    });
    sortTask();
  }

  void sortTask() {
    setState(() {
      filterTask.sort((a, b) {
        final intA = a.favorites ? 1 : 0;
        final intB = b.favorites ? 1 : 0;
        return intB - intA;
      });
      // filterDoneTask.sort((a, b) {
      //   final intA = a.favorites ? 1 : 0;
      //   final intB = b.favorites ? 1 : 0;
      //   return intB - intA;
      // });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
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
        favorites: false,
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

  void updateFavorites(bool? name, int index) {
    setState(() {
      final task = filterTask[index];
      task.favorites = name ?? false;
      task.save();
    });
    sortTask();
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
              favorites: item.favorites,
              onChanged: (value) => checkChange(value, index),
              updatestate: (value) => updateFavorites(value, index),
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
