import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  TimeOfDay dueTime;
  bool isComplete;

  Task({
    required this.title,
    required this.description,
    required this.dueTime,
    this.isComplete = false,
  });
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  TimeOfDay? filterTime;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  TimeOfDay? _selectedTime;
  bool _isComplete = false;

  void _addTaskDialog() {
    _titleController.clear();
    _descController.clear();
    _selectedTime = null;
    _isComplete = false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Task Title'),
                    validator:
                        (value) => value!.isEmpty ? 'Title is required' : null,
                  ),
                  TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Description is required' : null,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        _selectedTime == null
                            ? 'Select Due Time'
                            : 'Due: ${_selectedTime!.format(context)}',
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              _selectedTime = time;
                            });
                          }
                        },
                        child: Text('Pick Time'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Status: '),
                      Spacer(),
                      Text(_isComplete ? 'Complete' : 'Open'),
                      Switch(
                        value: _isComplete,
                        onChanged: (val) {
                          setState(() {
                            _isComplete = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    _selectedTime != null) {
                  setState(() {
                    tasks.add(
                      Task(
                        title: _titleController.text,
                        description: _descController.text,
                        dueTime: _selectedTime!,
                        isComplete: _isComplete,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _filterDialog() {
    TimeOfDay? _filterPickedTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter by Time"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _filterPickedTime == null
                    ? "Pick a time to filter"
                    : "Filter: ${_filterPickedTime?.format(context)}",
              ),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _filterPickedTime = picked;
                    });
                  }
                },
                child: Text("Pick Time"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  filterTime = _filterPickedTime;
                });
                Navigator.pop(context);
              },
              child: Text("Apply Filter"),
            ),
          ],
        );
      },
    );
  }

  List<Task> get filteredTasks {
    if (filterTime == null) return tasks;
    return tasks
        .where(
          (task) =>
              task.dueTime.hour == filterTime!.hour &&
              task.dueTime.minute == filterTime!.minute,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final taskList = filteredTasks;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("TODO App", style: TextStyle(fontSize: 24)),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.filter_alt), onPressed: _filterDialog),
          PopupMenuButton<String>(
            icon: Icon(Icons.person),
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.pushNamed(context, '/profile');
              } else if (value == 'logout') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/welcome',
                  (route) => false,
                );
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.account_circle, color: Colors.black54),
                        SizedBox(width: 10),
                        Text('Profile'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black54),
                        SizedBox(width: 10),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body:
          taskList.isEmpty
              ? Center(
                child: ElevatedButton(
                  onPressed: _addTaskDialog,
                  child: Text("Add Task"),
                ),
              )
              : RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    final task = taskList[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6),
                            Text(task.description),
                            SizedBox(height: 4),
                            Text(
                              "Due: ${task.dueTime.format(context)}",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text("Status: "),
                                Switch(
                                  value: task.isComplete,
                                  onChanged: (val) {
                                    setState(() {
                                      task.isComplete = val;
                                    });
                                  },
                                ),
                                Text(task.isComplete ? "Complete" : "Open"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      floatingActionButton:
          taskList.isNotEmpty
              ? FloatingActionButton(
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.add),
                onPressed: _addTaskDialog,
              )
              : null,
    );
  }
}
