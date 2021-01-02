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
  void initState() {
    Provider.of<TodoProvider>(context, listen: false).fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final height = (mediaQuery.size.height -
            (mediaQuery.padding.top + mediaQuery.padding.bottom)) /
        100;
    final width = (mediaQuery.size.width -
            (mediaQuery.padding.left + mediaQuery.padding.right)) /
        100;
    return FutureBuilder(
        future: provider.fetchdata().then((value) => null),
        builder: (context, snaphot) => provider.dates.length == 0
            ? Center(
                child: Text(
                  'Nothing to Display',
                  style: TextStyle(fontFamily: 'carterOne', fontSize: 25),
                ),
              )
            : ListView.builder(
                itemCount: provider.dates.length,
                itemBuilder: (context, index1) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        DateFormat.yMMMMd('en_US')
                            .format(provider.dates[index1]),
                        style: TextStyle(
                          fontFamily: 'carterOne',
                        )),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider
                              .map[DateFormat.yMMMMd('en_US')
                                  .format(provider.dates[index1])]
                              .length,
                          itemBuilder: (context, index2) => Dismissible(
                                key: Key(
                                    "${provider.map[DateFormat.yMMMMd('en_US').format(provider.dates[index1])][index2].datetime} ${provider.map[DateFormat.yMMMMd('en_US').format(provider.dates[index1])][index2].title}"),
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
                                        DateFormat().add_jm().format(provider
                                            .map[DateFormat.yMMMMd('en_US')
                                                    .format(
                                                        provider.dates[index1])]
                                                [index2]
                                            .datetime),
                                        style:
                                            TextStyle(fontFamily: 'carterOne'),
                                      ),
                                      title: Text(
                                        provider
                                            .map[DateFormat.yMMMMd('en_US')
                                                    .format(
                                                        provider.dates[index1])]
                                                [index2]
                                            .title,
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(fontFamily: 'carterOne'),
                                      )),
                                ),
                              )),
                    )
                  ],
                ),
              ));
  }
}
