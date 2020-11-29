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
      backgroundColor: Color.fromRGBO(232, 235, 247,1),
      appBar: AppBar(
        title: Text('ToDo App',style: TextStyle(fontFamily: 'carterOne'),),
        backgroundColor: Color.fromRGBO(222, 26, 26,1),
      ),
      body: SafeArea(
        
          child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: TodoList(),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(215, 133, 33,1),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/newtodo');
        },
      ),
    );
  }
}
