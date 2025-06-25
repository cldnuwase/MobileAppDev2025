import 'package:flutter/material.dart';

class TaskFormScreen extends StatefulWidget {
  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final TextEditingController taskController = TextEditingController();
  bool isDone = false;
  int? editingIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      if (args.containsKey('task')) {
        taskController.text = args['task'] ?? '';
      }
      if (args.containsKey('done')) {
        isDone = args['done'] ?? false;
      }
      if (args.containsKey('index')) {
        editingIndex = args['index'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add/Edit Task')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Task'),
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text('Mark as done'),
              value: isDone,
              onChanged: (value) {
                setState(() {
                  isDone = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'task': taskController.text,
                  'done': isDone,
                  if (editingIndex != null) 'index': editingIndex,
                });
              },
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
