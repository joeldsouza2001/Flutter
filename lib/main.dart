import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/new_todo.dart';
import './homescreen.dart';
import './provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: HomeScreen(),
      routes: {
        '/homescreen': (context) => HomeScreen(),
        '/newtodo': (context) => NewTodo(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
