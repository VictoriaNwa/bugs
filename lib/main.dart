import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  TaskState createState() => TaskState();
}

class TaskState extends State<TaskListScreen> {
  List<UserTask> tasks = [];
  TextEditingController input = TextEditingController();

  void addTask() {
    if (input.text.isNotEmpty) {
      setState(() {
        tasks.add(UserTask(name: input.text, done: false));
        input.clear();
      });
    }
  }

  void check(int num) {
    setState(() {
      tasks[num].done = !tasks[num].done;
    });
  }

  void removeTask(int num) {
    setState(() {
      tasks.removeAt(num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Task Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: input,
              decoration: InputDecoration(
                labelText: 'Input Task...',
              ),
            ),
            IconButton(
              onPressed: addTask,
              icon: Icon(Icons.add),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, num) {
                  return ListTile(
                    leading: Checkbox(
                      value: tasks[num].done,
                      onChanged: (value) {
                        check(num);
                      },
                    ),
                    title: Text(
                      tasks[num].name,
                      style: TextStyle(
                        decoration: tasks[num].done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeTask(num);
                      },
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

class UserTask {
  String name;
  bool done;
  UserTask({required this.name, this.done = false});
}

