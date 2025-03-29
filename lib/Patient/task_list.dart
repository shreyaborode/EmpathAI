import 'package:flutter/material.dart';
import 'package:gajni_ai/Patient/task.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task(name: 'Brush teeth'),
    Task(name: 'Take a bath/shower'),
    Task(name: 'Eat breakfast'),
    Task(name: 'Take morning medication'),
    Task(name: 'Call family'),
    Task(name: 'Read a book'),
    Task(name: 'Work meeting'),
    Task(name: 'Walk the dog'),
    Task(name: 'Have lunch'),
    Task(name: 'Do laundry'),
    Task(name: 'Meet friends'),
    Task(name: 'Evening exercise'),
    Task(name: 'Have dinner'),
    Task(name: 'Read'),
  ];

  void _toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      tasks.sort((a, b) => a.isCompleted ? 1 : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Checkbox(
            value: tasks[index].isCompleted,
            onChanged: (value) => _toggleTask(index),
          ),
          title: Text(
            tasks[index].name,
            style: TextStyle(
              fontSize: 18,
              decoration: tasks[index].isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: tasks[index].isCompleted ? Colors.grey : Colors.black,
            ),
          ),
        );
      },
    );
  }
}
