import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/provider/task_repo.dart';
import 'package:todolist/widgets/add_task.dart';
import 'package:todolist/widgets/task.dart';
import 'package:todolist/widgets/update_task.dart';
import 'package:uuid/uuid.dart';

class TodoTaskState extends StatefulWidget {
  final String categoryName;
  final String idCategory;
  const TodoTaskState({
    super.key,
    required this.categoryName,
    required this.idCategory,
  });

  @override
  State<TodoTaskState> createState() => ToDoTaskScreen();
}

class ToDoTaskScreen extends State<TodoTaskState> {
  void openTask(BuildContext context, ToDoTask task) {
    final repo = context.read<ToDoTaskRepository>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: repo,
          child: UpdateTask(categoryName: widget.categoryName, task: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ToDoTaskRepository>();
    final List<ToDoTask> tasksCompleted = [];
    bool isExpandedToDo = true;
    bool isExpandedCompleted = false;
    final List<ToDoTask> tasks = [];
    tasks.addAll(repo.tasks.where((task) => task.completed == false));
    tasksCompleted.addAll(repo.tasks.where((task) => task.completed == true));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.purple[200],
      ),
      backgroundColor: Colors.purple[50],
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: const Text('To do'),
            initiallyExpanded: isExpandedToDo,
            children: [
              tasks.isEmpty
                  ? ListTile(title: Text('No tasks'))
                  : SizedBox(
                      height: 350,
                      child: ListView.separated(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final item = tasks[index];
                          return Slidable(
                            key: ValueKey(item.key),
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => repo.deleteTask(item.id),
                                  icon: Icons.delete_outline,
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () => openTask(context, item),
                              child: TaskCard(
                                nameTask: item.nameTask,
                                taskCompleted: item.completed,
                                categoryName: item.idCategory,
                                isFavorite: item.isFavorite,
                                onStateChanged: (value) =>
                                    repo.checkChange(value, item.id),
                                updatestate: (value) => repo.updateFavorites(
                                  item.id,
                                  value ?? false,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                      ),
                    ),
            ],
          ),
          ExpansionTile(
            title: Text('Completed'),
            initiallyExpanded: isExpandedCompleted,
            children: [
              tasksCompleted.isEmpty
                  ? ListTile(title: Text('No tasks'))
                  : SizedBox(
                      height: 200,
                      child: ListView.separated(
                        itemCount: tasksCompleted.length,
                        itemBuilder: (context, index) {
                          final item = tasksCompleted[index];
                          return Slidable(
                            key: ValueKey(item.key),
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => repo.deleteTask(item.id),
                                  icon: Icons.delete_outline,
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () => openTask(context, item),
                              child: TaskCard(
                                nameTask: item.nameTask,
                                taskCompleted: item.completed,
                                categoryName: item.idCategory,
                                isFavorite: item.isFavorite,
                                onStateChanged: (value) =>
                                    repo.checkChange(value, item.id),
                                updatestate: (value) => repo.updateFavorites(
                                  item.id,
                                  value ?? false,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                      ),
                    ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddElement(
              addName: 'task',
              create: (context) {
                final uuid = Uuid();
                repo.addItemTask(
                  ToDoTask(
                    id: uuid.v4(),
                    nameTask: context,
                    completed: false,

                    idCategory: widget.idCategory,
                    isFavorite: false,
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
