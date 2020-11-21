import 'package:flutter/cupertino.dart';

class Todo {
  final String title;
  final DateTime date;
  final DateTime time;
  bool done;
  Todo(
      {@required this.date,
      @required this.time,
      @required this.title,
      this.done});
}

class TodoProvider with ChangeNotifier {
  List<Todo> _list = [
    Todo(date: DateTime.now(), time: DateTime.now(), title: 'Test', done: false),
    Todo(date: DateTime.now(), time: DateTime.now(), title: 'Test 2', done: false),
    Todo(date: DateTime.now(), time: DateTime.now(), title: 'Test 3', done: false),
  ];

  List<Todo> get list {
    return [..._list];
  }

  void add(Todo todo) {}
}
