import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/task.dart';

class TaskEditScreen extends StatelessWidget {
  final Task task;

  TaskEditScreen({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
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
            Get.back();
          },
        ),
      ),
      body:Padding(
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: titleController,
              obscureText: false,
              cursorColor: const Color(0xff757194),
              style: const TextStyle(color: Color(0xff4b4b4b), fontSize: 20),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffd1d1d1),
                hintText: 'Enter the title',
                hintStyle: const TextStyle(color: Color(0xff757194), fontFamily: 'FontMain', fontSize: 18,),
                floatingLabelStyle: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff1f1f1f),
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
                    color: const Color(0xfff2f2f2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: descriptionController,
              obscureText: false,
              cursorColor: const Color(0xff757194),
              style: const TextStyle(color: Color(0xff4b4b4b), fontSize: 20),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffd1d1d1),
                hintText: 'Enter description',
                hintStyle: const TextStyle(color: Color(0xff757194), fontFamily: 'FontMain', fontSize: 18,),
                floatingLabelStyle: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff1f1f1f),
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
                    color: const Color(0xfff2f2f2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final updatedTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: task.isCompleted,
                );
                Get.back(result: updatedTask);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff757194),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
