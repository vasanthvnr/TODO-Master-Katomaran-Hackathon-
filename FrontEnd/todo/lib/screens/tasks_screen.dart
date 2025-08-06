import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<String> _tasks = [
    "Buy groceries",
    "Call mechanic",
    "Team meeting at 4 PM",
  ];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    final task = _taskController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(task);
        _taskController.clear();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Task input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: "Add new task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Task list
            Expanded(
              child:
                  _tasks.isEmpty
                      ? const Center(child: Text("No tasks available"))
                      : ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(_tasks[index]),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeTask(index),
                              ),
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
