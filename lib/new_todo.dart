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
  DateTime pickedDate;
  bool isDate = false;
  TimeOfDay time;
  DateTime pickedTime;
  bool isTime = false;
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
      backgroundColor: Color.fromRGBO(232, 235, 247, 1),
      appBar: AppBar(
        title: Text(
          'Add an entry',
          style: TextStyle(fontFamily: 'carterOne'),
        ),
        backgroundColor: Color.fromRGBO(222, 26, 26, 1),
      ),
      body: Builder(
        builder: (context) => Container(
          margin: EdgeInsets.symmetric(horizontal: width * 3, vertical: height),
          padding: EdgeInsets.all(width),
          child: Column(
            children: [
              Form(
                // ignore: deprecated_member_use
                autovalidate: true,
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Title', focusColor: Colors.amber),
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
                      ? Text(
                          DateFormat.yMMMMd('en_US').format(pickedDate),
                          style:
                              TextStyle(fontFamily: 'carterOne', fontSize: 19),
                        )
                      : Text(
                          'Select a Date',
                          style:
                              TextStyle(fontFamily: 'carterOne', fontSize: 19),
                        ),
                  Spacer(),
                  RaisedButton.icon(
                    onPressed: () async {
                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                          firstDate: DateTime.now(),
                          builder:(context,child)=>Theme(data: ThemeData.light().copyWith(
                            //primaryColor: Colors.red,
                            //accentColor: Color.fromRGBO(215, 133, 33, 1),
                            colorScheme: ColorScheme.light(primary:  Color.fromRGBO(222, 26, 26, 1),)
                            
                          ),child: child,),
                          );
                      if (date == null) return;
                      setState(() {
                        pickedDate = date;
                        if (date != null) isDate = true;
                      });
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                    ),
                    label: Text(
                      'Pick a Date',
                    ),
                    color: Color.fromRGBO(215, 133, 33, 1),
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
                          style:
                              TextStyle(fontFamily: 'carterOne', fontSize: 19),
                        )
                      : Text(
                          'Select a Time',
                          style:
                              TextStyle(fontFamily: 'carterOne', fontSize: 19),
                        ),
                  Spacer(),
                  RaisedButton.icon(
                    onPressed: () async {
                      time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now(),
                          builder: (context,child)=>Theme(data: ThemeData.light().copyWith(
                            //primaryColor: Colors.red,
                            //accentColor: Color.fromRGBO(215, 133, 33, 1),
                            colorScheme: ColorScheme.light(primary:  Color.fromRGBO(222, 26, 26, 1),)
                            
                          ),child: child,));
                      if (time == null) return;
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
                    color: Color.fromRGBO(215, 133, 33, 1),
                  ),
                ],
              ),
              SizedBox(height: height * 10),
              RaisedButton.icon(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 20, vertical: height * 2),
                  color: Color.fromRGBO(215, 133, 33, 1),
                  onPressed: () {
                    if (titleController.text.length == 0) {
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Add a title', textAlign: TextAlign.center),
                        backgroundColor: Color.fromRGBO(215, 133, 33, 1),
                      ));
                    } else if (pickedDate == null || pickedTime == null) {
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Select a valid date and time',
                            textAlign: TextAlign.center),
                        backgroundColor: Color.fromRGBO(215, 133, 33, 1),
                      ));
                      return;
                    } else if (titleController.text.length >= 30) {
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Too lengthy title',
                            textAlign: TextAlign.center),
                        backgroundColor: Color.fromRGBO(215, 133, 33, 1),
                      ));
                    } else {
                      provider.addTodo(Todo(
                          date: pickedDate,
                          time: pickedTime,
                          title: titleController.text));
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
