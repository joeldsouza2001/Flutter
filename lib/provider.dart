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
    //print(list1);
    list1.forEach((element) {
      DateTime dt = DateTime.parse(element['date']);
      if (dates0.contains(DateTime.utc(dt.year, dt.month, dt.day, 0, 0, 0)) ==
          false) {
        dates0.add(DateTime.utc(dt.year, dt.month, dt.day, 0, 0, 0));
      }
      /*else {
         DBhelper.instance.deletedateentry(element['id'], null);
      }*/
    });
    dates0.sort((a, b) => a.compareTo(b));
    _dates = dates0;
    print(' list0: $list0');
    print('list1 $list1');
    print('map $_map');
    print('dates $_dates');
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

    await DBhelper.instance.insert(
        {'datetime': todo.datetime.toString(), 'title': todo.title},
        {'date': todo.datetime.toString()});

    /*if (_map.containsKey(DateFormat.yMMMMd('en_US').format(todo.datetime)) ==
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
    _dates.sort((a, b) => a.compareTo(b));*/
    await fetchdata();
    notifyListeners();
  }

  void deleteTodo(int ind1, int ind2) async {
    List temp = _map[DateFormat.yMMMMd('en_US').format(dates[ind1])];
    //print('temp:${temp[ind2].datetime}');
    //print(temp);
    var delmap = await DBhelper.instance.deletemapentry(temp[ind2]);
    //print('delmap:$delmap');
    var deldate = await DBhelper.instance.deletedateentry(temp[ind2]);
    //print('deldate:$deldate');
    //temp.removeAt(ind2);
    //print(temp);
    //map[DateFormat.yMMMMd('en_US').format(dates[ind1])] = temp;

    /*if (temp.length == 0) {
      map.removeWhere((key, value) =>
          key == (DateFormat.yMMMMd('en_US').format(dates[ind1])));
      _dates.removeAt(ind1);
      notifyListeners();
    }*/
    await fetchdata();
    notifyListeners();
  }
}
