import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import './dbhelper.dart';

class Todo {
  final String title;
  final DateTime datetime;
  //final String time;
  bool done;
  Todo(
      {@required this.datetime,
      //@required this.time,
      @required this.title,
      this.done});
}

class TodoProvider with ChangeNotifier {
  List<DateTime> _dates = [];
  //List<String> _dates0 = [];
  List<DateTime> get dates => _dates;
  Map<String, List<Todo>> _map = {};
  Map<String, List<Todo>> get map => _map;

  Future fetchdata() async {
    final List<Map<String, dynamic>> list0 =
        await DBhelper.instance.querytodolist();
    Map<String, List<Todo>> map0 = {};
    list0.forEach((ele) {
      if (map0.containsKey(DateFormat.yMMMMd('en_US')
              .format(DateTime.parse(ele['datetime']))) ==
          false) {
        map0.putIfAbsent(
            DateFormat.yMMMMd('en_US').format(DateTime.parse(ele['datetime'])),
            () => [
                  Todo(
                      datetime: DateTime.parse(ele['datetime']),
                      title: ele['title'])
                ]);
      } else {
        var templist = map0[
            DateFormat.yMMMMd('en_US').format(DateTime.parse(ele['datetime']))];
        templist.add(Todo(
            datetime: DateTime.parse(ele['datetime']), title: ele['title']));
        templist.sort((a, b) => (a.datetime).compareTo(b.datetime));
        //tempList.sort((a, b) => a.datetime.compareTo(b.datetime));

        map0[DateFormat.yMMMMd('en_US')
            .format(DateTime.parse(ele['datetime']))] = templist;
      }
      _map = map0;
    });
    List<DateTime> dates0 = [];
    final List<Map<String, dynamic>> list1 =
        await DBhelper.instance.querydates();
    list1.forEach((element) {
      DateTime dt = DateTime.parse(element['date']);
      if (dates0.contains(DateTime.utc(dt.year, dt.month, dt.day, 0, 0, 0)) ==
          false) {
        dates0.add(DateTime.utc(dt.year, dt.month, dt.day, 0, 0, 0));
      }
    });
    dates0.sort((a, b) => a.compareTo(b));
    _dates = dates0;
  }

  void addTodo(Todo todo) async {
    //DateTime dt = DateTime(todo.date.year, todo.date.month, todo.date.day,
    //    todo.time.hour, todo.time.minute);
    //DateTime dummydt = DateTime(todo.date.year, todo.date.month, todo.date.day);
    //print(dt);
    //print(dummydt);

    //if (_dates.contains(todo.date) == false) _dates.add(todo.date);
    //_dates.sort((a, b) => a.compareTo(b));
    //String time = DateFormat().add_jm().format(dt);
    //String date = DateFormat.yMMMMd('en_US').format(dt);
    //print(time);
    //print(date);

    /*if (map_.containsKey(todo.date) == false) {
      map_.putIfAbsent(todo.date,
          () => [Todo(date: todo.date, time: todo.time, title: todo.title)]);
    } else {
      var tempList = map_[todo.date];
      tempList.add(Todo(date: todo.date, time: todo.time, title: todo.title));
      tempList.sort((a, b) => a.time.compareTo(b.time));
      map_[todo.date] = tempList;
    }*/

 
    await DBhelper.instance.insert({
      'datetime': todo.datetime.toIso8601String(),
      'title': todo.title
    }, {
      'date': DateTime.utc(todo.datetime.year, todo.datetime.month,
              todo.datetime.day, 0, 0, 0)
          .toIso8601String()
    });

    if (_map.containsKey(DateFormat.yMMMMd('en_US').format(todo.datetime)) ==
        false) {
      _map.putIfAbsent(DateFormat.yMMMMd('en_US').format(todo.datetime),
          () => [Todo(datetime: todo.datetime, title: todo.title)]);
    } else {
      var tempList = _map[DateFormat.yMMMMd('en_US').format(todo.datetime)];
      tempList.add(Todo(datetime: todo.datetime, title: todo.title));
      tempList.sort((a, b) => a.datetime.compareTo(b.datetime));
      _map[DateFormat.yMMMMd('en_US').format(todo.datetime)] = tempList;
    }
    if (_dates.contains(DateTime.utc(todo.datetime.year, todo.datetime.month,
            todo.datetime.day, 0, 0, 0)) ==
        false) {
      _dates.add(DateTime.utc(
          todo.datetime.year, todo.datetime.month, todo.datetime.day, 0, 0, 0));
    }
    _dates.sort((a, b) => a.compareTo(b));
    notifyListeners();
  }

  void deleteTodo(int ind1, int ind2) {
    List temp = map[dates[ind1]];
    temp.removeAt(ind2);
    // map[dates[ind1]] = temp;
    if (temp.length == 0) {
      map.removeWhere((key, value) => key == dates[ind1]);
      _dates.removeAt(ind1);
      notifyListeners();
    }
    notifyListeners();
  }
}
