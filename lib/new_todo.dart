import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = (mediaQuery.size.height -
            (mediaQuery.padding.top + mediaQuery.padding.bottom)) /
        100;
    final width = (mediaQuery.size.width -
            (mediaQuery.padding.left + mediaQuery.padding.right)) /
        100;
    final provider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add an entry'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 3, vertical: height),
        padding: EdgeInsets.all(width),
        child: Column(
          children: [
            Form(
              // ignore: deprecated_member_use
              autovalidate: true,
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                validator: (String text) {
                  if (text.length > 30) {
                    return 'Too lengthy';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: height * 5,
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
                      if (date != null) isDate = true;
                    });
                  },
                  icon: Icon(Icons.calendar_today_outlined),
                  label: Text('Pick a Date'),
                  color: Colors.amberAccent,
                )
              ],
            ),
            SizedBox(
              height: height * 5,
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
                        if (t != null) isTime = true;
                      });
                    },
                    icon: Icon(Icons.alarm),
                    label: Text('Pick a Time'),
                    color: Colors.amberAccent)
              ],
            ),
            SizedBox(height: height * 10),
            RaisedButton.icon(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 20, vertical: height * 2),
                color: Colors.amber,
                onPressed: () {
                  if (titleController.text.length <= 30) {
                    provider.addTodo(Todo(
                        date: pickedDate,
                        time: pickedTime,
                        title: titleController.text));
                    //Navigator.of(context).pop();
                  }
                },
                icon: Icon(Icons.save),
                label: Text('Save'))
          ],
        ),
      ),
    );
  }
}
