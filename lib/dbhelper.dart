import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import './provider.dart';


class DBhelper {
  DBhelper._privateConstructor();
  static final DBhelper instance = DBhelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'my_db.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'create table todo_list(id integer primary key,datetime text,title text)');
        await db
            .execute('create table dates(id integer primary key,date text)');
      },
    );
    return _database;
  }

  Future<int> insert(Map<String, String> map, date) async {
    Database db = await instance.database;
    //await db.delete('todo_list');
    //await db.delete('dates');
    await db.insert('dates', date);
    return await db.insert('todo_list', map);
    //Directory directory = await getApplicationDocumentsDirectory();
    //String path = join(directory.path, 'my_db.db');
    //await deleteDatabase(path);
  }
  Future deleteall() async{
    Database db = await instance.database;
    await db.delete('todo_list');
    await db.delete('dates');
  }

  Future<List<Map<String, dynamic>>> querytodolist() async {
    Database db = await instance.database;
    return await db.query('todo_list');
  }

  Future<List<Map<String, dynamic>>> querydates() async {
    Database db = await instance.database;
    return await db.query('dates');
  }

  Future<int> deletemapentry(Todo todo) async {
    //print('${todo.datetime}||${todo.title}');
    /*print(new DateTime.now().toString());
    print(new DateTime.now().toString());*/
    Database db = await instance.database;
    return await db.delete('todo_list',
        where: 'datetime=? AND title=?',
        whereArgs: [todo.datetime.toString(),todo.title]);
    
  }

  Future<int> deletedateentry(Todo todo) async {
    Database db = await instance.database;

    return await db.delete('dates',
        where: 'date=?', whereArgs: [todo.datetime.toString()]);
  }
}
