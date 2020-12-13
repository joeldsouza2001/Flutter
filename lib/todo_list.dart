import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import './provider.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final list = provider.dates;
    //print(provider.map['2020-11-25T19:37:49.359931'][0]);
    //print(DateFormat().add_yMd().add_jm().format(DateTime.parse('2020-11-24T21:42:27.390176'))  );
    final mediaQuery = MediaQuery.of(context);
    final height = (mediaQuery.size.height -
            (mediaQuery.padding.top + mediaQuery.padding.bottom)) /
        100;
    final width = (mediaQuery.size.width -
            (mediaQuery.padding.left + mediaQuery.padding.right)) /
        100;
    //print('$height | $width');
    return provider.dates.length == 0
        ? Center(
            child: Text(
              'Nothing to Display',
              style: TextStyle(fontFamily: 'carterOne', fontSize: 25),
            ),
          )
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index1) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(list[index1],
                    style: TextStyle(
                      fontFamily: 'carterOne',
                    )),
                Container(
                  //height: 100,
                  //padding: EdgeInsets.all(5),
                  //color: Colors.yellowAccent,

                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,//provider.map[list[index1]].length,
                      itemBuilder: (context, index2) => Dismissible(
                            /*key: Key(provider.map[list[index1]][index2].time
                                .toString()),*/
                            background: Container(
                              padding: EdgeInsets.only(left: 15),
                              margin: EdgeInsets.all(5),
                              color: Color.fromRGBO(222, 26, 26, 1),
                              child: Icon(
                                Icons.delete,
                                size: 30,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              provider.deleteTodo(index1, index2);
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              color: Color.fromRGBO(242, 211, 152, 1),
                              child: ListTile(
                                  leading: Text(
                                    provider
                                        .map[list[index1]][index2].time,
                                    style: TextStyle(fontFamily: 'carterOne'),
                                  ),
                                  title: Text('.'
                                    /*provider.map[provider.dates[index1]][index2]
                                        .title*/,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: 'carterOne'),
                                  )),
                            ),
                          )
                      //Text(DateFormat.jm().format(provider.map[provider.dates[index1]][index2].time)),
                      ),
                )
              ],
            ),
          );
  }
}
