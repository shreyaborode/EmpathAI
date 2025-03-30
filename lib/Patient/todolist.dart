import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ToDoListScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class Task {
  String name;
  String time;
  bool isDone;

  Task({required this.name, required this.time, this.isDone = false});
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<Task> tasks = [
    Task(name: 'Brush teeth', time: '07:00 AM'),
    Task(name: 'Take a bath/shower', time: '07:30 AM'),
    Task(name: 'Eat breakfast', time: '08:00 AM'),
    Task(name: 'Take morning medication', time: '08:30 AM'),
    Task(name: 'Call family', time: '09:00 AM'),
    Task(name: 'Read a book', time: '10:00 AM'),
    Task(name: 'Work meeting', time: '11:00 AM'),
    Task(name: 'Walk the dog', time: '12:00 PM'),
    Task(name: 'Have lunch', time: '01:00 PM'),
    Task(name: 'Do laundry', time: '02:00 PM'),
    Task(name: 'Meet friends', time: '05:00 PM'),
    Task(name: 'Evening exercise', time: '06:00 PM'),
    Task(name: 'Have dinner', time: '08:00 PM'),
    Task(name: 'Read', time: '09:00 PM'),
  ];

  void _toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
      tasks.sort((a, b) => a.isDone ? 1 : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To-Do List',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Checkbox(
                        value: tasks[index].isDone,
                        onChanged: (value) => _toggleTask(index),
                      ),
                      title: Text(
                        tasks[index].name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: tasks[index].isDone ? TextDecoration.lineThrough : null,
                          color: tasks[index].isDone ? Colors.grey : Colors.black,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.alarm, color: Colors.redAccent, size: 20),
                          SizedBox(width: 5),
                          Text(
                            tasks[index].time,
                            style: TextStyle(
                              fontSize: 16,
                              color: tasks[index].isDone ? Colors.grey : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      tileColor: tasks[index].isDone ? Colors.grey.shade200 : Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}