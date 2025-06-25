import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [
    {'task': 'Buy groceries', 'done': false},
    {'task': 'Walk the dog', 'done': false},
    {'task': 'Read a book', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Help'),
                  content: Text(
                    'To add a new task, tap the + button. To mark a task as done, use the checkbox. Tap a task to edit it.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            tasks[index]['task'],
            style: TextStyle(
              decoration: tasks[index]['done']
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          leading: Checkbox(
            value: tasks[index]['done'],
            onChanged: (value) {
              setState(() {
                tasks[index]['done'] = value ?? false;
              });
            },
          ),
          trailing: Icon(Icons.edit),
          onTap: () async {
            final result = await Navigator.pushNamed(
              context,
              '/task-form',
              arguments: {
                'task': tasks[index]['task'],
                'done': tasks[index]['done'],
                'index': index,
              },
            );
            if (result != null && result is Map<String, dynamic>) {
              if (result.containsKey('index')) {
                setState(() {
                  tasks[result['index']] = {
                    'task': result['task'],
                    'done': result['done'],
                  };
                });
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/task-form');
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              tasks.add(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
