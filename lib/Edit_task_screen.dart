import 'package:flutter/material.dart';

import 'main.dart';

class TaskEditScreen extends StatefulWidget {
  final Task task;

  TaskEditScreen({required this.task, Key? key}) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    isCompleted = widget.task.isCompleted;
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
        title: Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Task!',
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
                      color: const Color(0xff757194),
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
                controller: descriptionController,
                obscureText: false,
                cursorColor: const Color(0xff757194),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffe4e4e9), // Background color
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
              const SizedBox(height: 20.0),
              // CheckboxListTile(
              //   title: Text(
              //     'Completed',
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //       color: const Color(0xff757194),
              //     ),
              //   ),
              //   value: isCompleted,
              //   onChanged: (value) {
              //     setState(() {
              //       isCompleted = value!;
              //     });
              //   },
              // ),
              ElevatedButton(
                onPressed: () {
                  final updatedTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    isCompleted: isCompleted,
                  );
                  Navigator.pop(context, updatedTask);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff757194), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Button border radius
                  ),
                  minimumSize: Size(double.infinity, 60), // Match button height
                ),
                child: const Text(
                  'Save Changes',
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
      ),
    );
  }
}