import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTodo extends StatefulWidget {
  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  DateTime date;
  DateTime pickedDate = DateTime.now();
  bool isDate = false;
  TimeOfDay time;
  DateTime pickedTime = DateTime.now();
  bool isTime = false;
  final tstyle = TextStyle(fontSize: 19, fontWeight: FontWeight.w600);
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = (mediaQuery.size.height -
            (mediaQuery.padding.top + mediaQuery.padding.bottom)) /
        100;
    final width = (mediaQuery.size.width -
            (mediaQuery.padding.left + mediaQuery.padding.right)) /
        100;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an entry'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 3, vertical: height),
        padding: EdgeInsets.all(width),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            SizedBox(
              height: height * 4,
            ),
            Row(
              children: [
                isDate
                    ? Text(DateFormat.yMMMMd('en_US').format(pickedDate),
                        style: tstyle)
                    : Text(
                        'Select a Date',
                        style: tstyle,
                      ),
                Spacer(),
                RaisedButton.icon(
                  onPressed: () async {
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                        firstDate: DateTime.now());
                    setState(() {
                      pickedDate = date;
                      isDate = true;
                    });
                  },
                  icon: Icon(Icons.calendar_today_outlined),
                  label: Text('Pick a Date'),
                  color: Colors.amberAccent,
                )
              ],
            ),
            SizedBox(
              height: height * 4,
            ),
            Row(
              children: [
                isTime
                    ? Text(
                        DateFormat().add_jm().format(pickedTime),
                        style: tstyle,
                      )
                    : Text(
                        'Select a Time',
                        style: tstyle,
                      ),
                Spacer(),
                RaisedButton.icon(
                    onPressed: () async {
                      time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      DateTime now = DateTime.now();
                      DateTime t = DateTime(
                          now.day, now.month, now.year, time.hour, time.minute);
                      setState(() {
                        pickedTime = t;
                        isTime = true;
                      });
                    },
                    icon: Icon(Icons.alarm),
                    label: Text('Pick a Time'),
                    color: Colors.amberAccent)
              ],
            )
          ],
        ),
      ),
    );
  }
}
