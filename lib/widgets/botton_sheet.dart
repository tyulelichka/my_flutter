import 'package:flutter/material.dart';
import 'package:todolist/data/repeat_type.dart';
import 'package:todolist/data/to_do_list.dart';

class RepeatSheet extends StatefulWidget {
  RepeatType selectedRepeat;
  final void Function(String taskId, RepeatType repeatType) onUpdate;
  final ToDoTask task;

  RepeatSheet({
    required this.selectedRepeat,
    required this.onUpdate,
    required this.task,
  });

  @override
  State<RepeatSheet> createState() => RepeatSheetState();
}

class RepeatSheetState extends State<RepeatSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select repeatability",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              DropdownButton<RepeatType>(
                value: widget.selectedRepeat,
                isExpanded: true,
                items: RepeatType.values.map((repeat) {
                  return DropdownMenuItem<RepeatType>(
                    value: repeat,
                    child: Text(repeat.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      widget.selectedRepeat = value;
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
                  onPressed: widget.selectedRepeat == widget.task.repeat
                      ? null
                      : () {
                          widget.onUpdate(
                            widget.task.taskId,
                            widget.selectedRepeat,
                          );
                          Navigator.pop(context);
                        },

                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
