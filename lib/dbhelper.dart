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
      },
    );
    return _database;
  }

  Future<int> insert(Map<String, String> map) async {
    Database db = await instance.database;
    return await db.insert('todo_list', map);
  }

  Future<List<Map<String, dynamic>>> querytodolist() async {
    Database db = await instance.database;
    return await db.query('todo_list');
  }

  Future<int> deletemapentry(Todo todo) async {
    Database db = await instance.database;
    return await db.delete('todo_list',
        where: 'datetime=? AND title=?',
        whereArgs: [todo.datetime.toString(), todo.title]);
  }
}
