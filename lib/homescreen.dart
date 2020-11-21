import 'package:flutter/material.dart';
import './todo_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: TodoList(),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, '/newtodo');
        },
      ),
    );
  }
}
