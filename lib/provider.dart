import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import './dbhelper.dart';

class Todo {
  final String title;
  final DateTime datetime;
  bool done;
  Todo({@required this.datetime, @required this.title, this.done});
}

class TodoProvider with ChangeNotifier {
  List<DateTime> _dates = [];
  List<DateTime> get dates => _dates;
  Map<String, List<Todo>> _map = {};
  Map<String, List<Todo>> get map => _map;

  Future fetchdata() async {
    final List<Map<String, dynamic>> fetchedList =
        await DBhelper.instance.querytodolist();
    Map<String, List<Todo>> map0 = {};
    fetchedList.forEach((ele) {
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

        map0[DateFormat.yMMMMd('en_US')
            .format(DateTime.parse(ele['datetime']))] = templist;
      }
      _map = map0;
    });
    List<DateTime> dates0 = [];
    fetchedList.forEach((element) {
      DateTime dt = DateTime.parse(element['datetime']);
      if (dates0.contains(DateTime.utc(dt.year, dt.month, dt.day, 0, 0, 0)) ==
          false) {
        dates0.add(DateTime.utc(dt.year, dt.month, dt.day, 0, 0, 0));
      }
    });
    dates0.sort((a, b) => a.compareTo(b));
    _dates = dates0;
  }

  void addTodo(Todo todo) async {
    await DBhelper.instance
        .insert({'datetime': todo.datetime.toString(), 'title': todo.title});
    await fetchdata();
    notifyListeners();
  }

  void deleteTodo(int ind1, int ind2) async {
    List temp = _map[DateFormat.yMMMMd('en_US').format(dates[ind1])];
    var delmap = await DBhelper.instance.deletemapentry(temp[ind2]);
    await fetchdata();
    notifyListeners();
  }
}
