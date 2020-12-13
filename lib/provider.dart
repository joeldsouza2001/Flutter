import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import './dbhelper.dart';

class Todo {
  final String title;
  final String date;
  final String time;
  bool done;
  Todo(
      {@required this.date,
      @required this.time,
      @required this.title,
      this.done});
}

class TodoProvider with ChangeNotifier {
  Map<String, List<Todo>> map = {};
  void init() async {
    final List<Map<String, dynamic>> list = await DBhelper.instance.queryAll();
    list.forEach((ele) {
      if (map.containsKey(ele['date']) == false) {
        map.putIfAbsent(
            ele['date'],
            () => [
                  Todo(
                      date: ele['date'], time: ele['time'], title: ele['title'])
                ]);
      } else {
        var templist = map[ele['date']];
        templist.add(
            Todo(date: ele['date'], time: ele['time'], title: ele['title']));
      }
    });
    print(map);
  }

  List<String> _dates = [];
  //List<String> _dates0 = [];
  List<String> get dates => _dates;

  void addTodo(Todo todo) async {
    //DateTime dt = DateTime(todo.date.year, todo.date.month, todo.date.day,
    //    todo.time.hour, todo.time.minute);
    //DateTime dummydt = DateTime(todo.date.year, todo.date.month, todo.date.day);
    //print(dt);
    //print(dummydt);

    if (_dates.contains(todo.date) == false) _dates.add(todo.date);
    _dates.sort((a, b) => a.compareTo(b));
    //String time = DateFormat().add_jm().format(dt);
    //String date = DateFormat.yMMMMd('en_US').format(dt);
    //print(time);
    //print(date);

    /*if (map.containsKey(todo.date) == false) {
      map.putIfAbsent(todo.date,
          () => [Todo(date: todo.date, time: todo.time, title: todo.title)]);
    } else {
      var tempList = map[todo.date];
      tempList.add(Todo(date: todo.date, time: todo.time, title: todo.title));
      tempList.sort((a, b) => a.time.compareTo(b.time));
      map[todo.date] = tempList;
    }*/

    //print(dates);
    //print(map);
    final priKey = await DBhelper.instance
        .insert({'date': todo.date, 'time': todo.time, 'task': todo.title});

    print(map);
    notifyListeners();
  }

  void deleteTodo(int ind1, int ind2) {
    List temp = map[dates[ind1]];
    temp.removeAt(ind2);
    map[dates[ind1]] = temp;
    if (temp.length == 0) {
      map.removeWhere((key, value) => key == dates[ind1]);
      _dates.removeAt(ind1);
      notifyListeners();
    }
    notifyListeners();
  }
}
