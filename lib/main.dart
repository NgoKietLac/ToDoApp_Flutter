import 'package:app_todo_application/ListPageScreen/list_page_screen.dart';
import 'package:app_todo_application/ManagerTime/manager_time_screen.dart';
import 'package:app_todo_application/SettingPageScreen/setting_page_Screen.dart';
import 'package:app_todo_application/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppToDo',
      home: SplashScreen(),
      // home: ListPage(),
    );
  }
}
