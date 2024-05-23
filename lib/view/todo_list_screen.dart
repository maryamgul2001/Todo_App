import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/task_edit_screen.dart';
import 'package:todo_app/view/task_form_screen.dart';
import '../controller/task_controller.dart';
import '../model/task.dart';

class TodoListScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

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
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
            child: TextField(
              controller: taskController.searchController,
              onChanged: taskController.onSearchTextChanged,
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
                    taskController.searchController.clear();
                    taskController.onSearchTextChanged('');
                  },
                ),
                prefixIcon: GestureDetector(
                  onTap: () {
                    taskController.onSearchTextChanged(taskController.searchController.text);
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
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.tasks[index];

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    elevation: 2.0,
                    child: CustomTaskTile(
                      task: task,
                      onTaskCompleted: (newValue) {
                        if (newValue != null) {
                          taskController.onTaskCompleted(index, newValue);
                        }
                      },
                      onEditPressed: () async {
                        final updatedTask = await Get.to(() => TaskEditScreen(task: task));
                        if (updatedTask != null) {
                          taskController.updateTask(index, updatedTask);
                        }
                      },
                      onDeletePressed: () {
                        taskController.deleteTask(index);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Get.to(() => const TaskFormScreen());
          if (newTask != null) {
            taskController.addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xffbcbcc7),
      ),
    );
  }
}

class CustomTaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onTaskCompleted;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const CustomTaskTile({
    Key? key,
    required this.task,
    required this.onTaskCompleted,
    required this.onEditPressed,
    required this.onDeletePressed,
  }) : super(key: key);

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
          decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text(task.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEditPressed,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDeletePressed,
          ),
        ],
      ),
    );
  }
}
