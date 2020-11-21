import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import './provider.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final height = (mediaQuery.size.height -(mediaQuery.padding.top + mediaQuery.padding.bottom))/100;
    final width = (mediaQuery.size.width - (mediaQuery.padding.left + mediaQuery.padding.right))/100;
    //print('$height | $width');
    return ListView.builder(
      itemCount: provider.list.length,
      itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  DateFormat.yMMMMd('en_US').format(provider.list[index].date)),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(width),
                child: ListTile(
                  leading: Text(
                      '${DateFormat().add_jm().format(provider.list[index].time)}'),
                  title: Text(
                    '${provider.list[index].title}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
