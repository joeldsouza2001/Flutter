import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/new_todo.dart';
import './homescreen.dart';
import './provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: HomeScreen(),
      routes: {
        '/homescreen':(context)=>HomeScreen(),
        '/newtodo':(context)=>NewTodo(),
      },
      debugShowCheckedModeBanner: false,
      
    );
  }
}

/*class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime date;
  DateTime pickedDate = DateTime.now();
  TimeOfDay time;
  DateTime pickedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton.icon(
                    onPressed: () async {
                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 10),
                          firstDate: DateTime(DateTime.now().year - 10));
                      setState(() {
                        pickedDate = date;
                      });
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text('Date')),
                RaisedButton.icon(
                    onPressed: () async {
                      time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      DateTime now = DateTime.now();
                      DateTime t = DateTime(
                          now.day, now.month, now.year, time.hour, time.minute);
                      setState(() {
                        pickedTime = t;
                      });
                    },
                    icon: Icon(Icons.access_time),
                    label: Text('time')),
              ],
            ),
            Text(DateFormat.yMMMMd('en_US').format(pickedDate)),
            Text(DateFormat().add_jm().format(pickedTime)),
          ],
        ),
      ),
    );
  }
}*/
