import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Splash_screen.dart';

import 'Edit_task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primaryColor: const Color(0xff757194),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? taskStrings = prefs.getStringList('tasks');
    if (taskStrings != null) {
      tasks = taskStrings.map((taskString) => Task.fromString(taskString)).toList();
      setState(() {});
    }
  }

  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final taskStrings = tasks.map((task) => task.toString()).toList();
    prefs.setStringList('tasks', taskStrings);
  }

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
      saveTasks();
    });
  }

  void updateTask(int index, Task updatedTask) {
    setState(() {
      tasks[index] = updatedTask;
      saveTasks();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      saveTasks();
    });
  }

  void onSearchTextChanged(String query) {
    // Filter tasks based on the search query
    setState(() {
      tasks = tasks.where((task) {
        final title = task.title.toLowerCase();
        final description = task.description.toLowerCase();
        final lowercaseQuery = query.toLowerCase();
        return title.contains(lowercaseQuery) || description.contains(lowercaseQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'FontMain',
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          // Search bar
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
            child: TextField(
              controller: searchController,
              onChanged: onSearchTextChanged,
              cursorColor: Color(0xff757194),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffc2c2c2),
                hintText: 'Search Tasks',
                hintStyle: TextStyle(
                  color: Color(0xff757194),
                  fontFamily: 'FontMain',
                  fontSize: 18,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Color(0xff757194),
                  ),
                  onPressed: () {
                    searchController.clear();
                    onSearchTextChanged('');
                  },
                ),
                prefixIcon: GestureDetector(
                  onTap: () {
                    onSearchTextChanged(searchController.text);
                  },
                  child: Icon(
                    Icons.search,
                    color: Color(0xff757194),
                    size: 25,
                  ),
                ),
                floatingLabelStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: const BorderSide(color: Color(0xfff5f5f5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(
                    color: Color(0xfff2f2f2),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 2.0,
                  child: CustomTaskTile(
                    task: task,
                    onTaskCompleted: (newValue) {
                      if (newValue != null) {
                        onTaskCompleted(index, newValue);
                      }
                    },
                    onEditPressed: () async {
                      final updatedTask = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskEditScreen(task: task),
                        ),
                      );

                      if (updatedTask != null) {
                        updateTask(index, updatedTask);
                      }
                    },
                    onDeletePressed: () {
                      deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskFormScreen()),
          );
          if (newTask != null) {
            addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xffbcbcc7),
      ),
    );
  }

  void onTaskCompleted(int index, bool newValue) {
    setState(() {
      tasks[index] = tasks[index].copyWith(isCompleted: newValue);
      saveTasks();
    });
  }
}

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Task!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontFamily: 'FontStylish',
                color: const Color(0xff757194),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: titleController,
              obscureText: false,
              cursorColor: const Color(0xff757194),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffe4e4e9),
                hintText: "Title",
                labelText: "Title",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelStyle: TextStyle(
                  color: const Color(0xff757194),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: const Color(0xff757194), // Focus border color
                    width: 2, // Increase width
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: descriptionController,
              obscureText: false,
              cursorColor: const Color(0xff757194),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffe4e4e9),
                hintText: "Description",
                labelText: "Description",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelStyle: TextStyle(
                  color: const Color(0xff757194),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: const Color(0xff757194),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                Navigator.pop(context, newTask);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff757194),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 60),
              ),
              child: const Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'FontMain',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String title;
  final String description;
  final bool isCompleted;

  Task({
    required this.title,
    this.description = '',
    this.isCompleted = false,
  });

  Task copyWith({String? title, String? description, bool? isCompleted}) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return '$title|$description|$isCompleted';
  }

  static Task fromString(String taskString) {
    final parts = taskString.split('|');
    return Task(
      title: parts[0],
      description: parts[1],
      isCompleted: parts[2] == 'true',
    );
  }
}

class CustomTaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onTaskCompleted;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  CustomTaskTile({
    required this.task,
    required this.onTaskCompleted,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: onTaskCompleted,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        task.description,
        style: TextStyle(fontSize: 16.0),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: const Color(0xff757194),
              size: 25.0,
            ),
            onPressed: onEditPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 25.0,
            ),
            onPressed: onDeletePressed,
          ),
        ],
      ),
    );
  }
}
