import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/to_do_list.dart';
import 'package:todolist/provider/icons_repo.dart';
import 'package:todolist/provider/task_repo.dart';

class UpdateTask extends StatefulWidget {
  final String categoryName;
  final ToDoTask task;

  const UpdateTask({super.key, required this.categoryName, required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  void _openCategorySheet(BuildContext context) {
    final repo = context.read<ToDoTaskRepository>();
    String selectedCategoryId = widget.task.idCategory;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Move task to category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  DropdownButton<String>(
                    value: selectedCategoryId,
                    isExpanded: true,
                    items: repo.categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.id,
                        child: Row(
                          children: [
                            Icon(
                              IconsRepository.getIcon(category.iconName),
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 10),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setModalState(() {
                          selectedCategoryId = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[200],
                      ),
                      onPressed: selectedCategoryId == widget.task.idCategory
                          ? null
                          : () {
                              repo.moveTaskToCategory(
                                taskId: widget.task.id,
                                newIdCategory: selectedCategoryId,
                              );
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                      child: const Text(
                        "Move",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ToDoTaskRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.purple[200],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.purple[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.purple[100],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: widget.task.completed,
                        onChanged: (value) {
                          setState(() {
                            repo.checkChange(value ?? false, widget.task.id);
                          });
                        },
                      ),
                      Text(
                        widget.task.nameTask,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: widget.task.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        repo.updateFavorites(
                          widget.task.id,
                          !widget.task.isFavorite,
                        );
                      });
                    },
                    icon: Icon(
                      widget.task.isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: const Color.fromARGB(255, 50, 49, 49),
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.purple[100],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 15.0,
              ),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () => _openCategorySheet(context),
                    icon: Icon(Icons.compare_arrows_outlined),
                    label: Text(
                      'Change category',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll<Color>(
                        const Color.fromARGB(255, 0, 0, 0),
                      ),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        const Color.fromARGB(255, 225, 190, 231),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
