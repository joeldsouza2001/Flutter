import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
  Map<String, List<Todo>> map = {};

  List<String> _dates = [];
  List<DateTime> _dummyDates = [];
  List<String> get dates => _dates;

  /*List<Todo> _todo = [];
  List<Todo> get todo {
    return [..._todo];
  }*/

  void addTodo(Todo todo) {
    /*final dt = DateFormat.yMMMMd('en_US').add_jm().format(DateTime(
        todo.date.year,
        todo.date.month,
        todo.date.day,
        todo.time.hour,
        todo.time.minute));
    print(dt);*/
    //print('${todo.date}  ${todo.time}');
    DateTime dt = DateTime(todo.date.year, todo.date.month, todo.date.day,
        todo.time.hour, todo.time.minute);
    DateTime dummydt = DateTime(todo.date.year, todo.date.month, todo.date.day);
    //print(dummydt);
    if (_dummyDates.contains(dummydt) == false) _dummyDates.add(dummydt);
    _dummyDates.sort((a, b) => a.compareTo(b));
    String time = DateFormat().add_jm().format(dt);
    String date = DateFormat.yMMMMd('en_US').format(dt);
    //print('$date  $time');
    //print('$date  $time');
    _dates = [];
    _dummyDates.forEach((e) {
      _dates.add(DateFormat.yMMMMd('en_US').format(e));
    });

    if (map.containsKey(date) == false) {
      map.putIfAbsent(
          date, () => [Todo(date: dt, time: dt, title: todo.title)]);
    } else {
      var tempList = map[date];
      tempList.add(Todo(date: dt, time: dt, title: todo.title));
      tempList.sort((a, b) => a.time.compareTo(b.time));
      map[date] = tempList;
    }

    //_todo.add(Todo(date: dt, time: dt, title: todo.title));
    //_todo.sort((a, b) => a.time.compareTo(b.time));
    //print(_dates);
    //print(_todo);
    print(map);
    print(_dates);
    //print(map['November 27, 2020'].length);
    notifyListeners();
  }
}
