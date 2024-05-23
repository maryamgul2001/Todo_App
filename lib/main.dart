import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primaryColor: Color(0xff757194),
      ),
      home: SplashScreen(),
    );
  }
}

