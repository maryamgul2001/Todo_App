import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/task.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? taskStrings = prefs.getStringList('tasks');
    if (taskStrings != null) {
      tasks.assignAll(taskStrings.map((taskString) => Task.fromString(taskString)).toList());
    }
  }

  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final taskStrings = tasks.map((task) => task.toString()).toList();
    prefs.setStringList('tasks', taskStrings);
  }

  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
  }

  void updateTask(int index, Task updatedTask) {
    tasks[index] = updatedTask;
    saveTasks();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasks();
  }

  void onSearchTextChanged(String query) {
    // Filter tasks based on the search query
    final lowercaseQuery = query.toLowerCase();
    tasks.assignAll(tasks.where((task) {
      final title = task.title.toLowerCase();
      final description = task.description.toLowerCase();
      return title.contains(lowercaseQuery) || description.contains(lowercaseQuery);
    }).toList());
  }

  void onTaskCompleted(int index, bool newValue) {
    tasks[index] = tasks[index].copyWith(isCompleted: newValue);
    saveTasks();
  }
}
