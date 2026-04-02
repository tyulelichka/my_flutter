import 'package:flutter/material.dart';
import 'package:todolist/provider/task_repo.dart';

class UpdateDeadline extends StatefulWidget {
  final void Function(DateTime date) onSave;
  final DateTime initialDate;
  final ValueNotifier<DateTime> selectedDate;

  const UpdateDeadline({
    super.key,
    required this.onSave,
    required this.initialDate,
    required this.selectedDate,
  });

  @override
  State<UpdateDeadline> createState() => UpdateDeadlineState();
}

class UpdateDeadlineState extends State<UpdateDeadline> {
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
    return ValueListenableBuilder<DateTime>(
      valueListenable: widget.selectedDate,
      builder: (context, value, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select deadline",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  widget.selectedDate.value = pickedDate;
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("${value.day}.${value.month}.${value.year}"),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[200],
                ),
                onPressed: value.isSameDate(widget.initialDate)
                    ? null
                    : () {
                        widget.onSave(value);
                        Navigator.pop(context);
                      },

                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
