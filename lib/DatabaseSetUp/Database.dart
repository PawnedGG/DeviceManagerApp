import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_manager/Model/Light.dart';
import 'package:smart_manager/Model/Room.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/User.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider dbProviderInstance = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, 'smartAppDB.db');
    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE USER
      (
      ${User.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${User.colMail} TEXT NOT NULL,
      ${User.colName} TEXT NOT NULL,
      ${User.colPswd} TEXT NOT NULL
      )
     ''');
    await db.execute('''
      CREATE TABLE ROOM
      (
      ${Room.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Room.colName} TEXT NOT NULL
      )
     ''');
    await db.execute('''
      CREATE TABLE LIGHT
      (
      ${Light.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Light.colName} TEXT NOT NULL,
      ${Light.colRoom} TEXT NOT NULL
      )
     ''');
  }

  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('USER', user.toMap());
  }
  Future<int> insertRoom(Room room) async {
    Database db = await database;
    return await db.insert('ROOM', room.toMap());
  }
  Future<int> insertLight(Light light) async {
    Database db = await database;
    return await db.insert('LIGHT', light.toMap());
  }
  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db.update(
        'USER', user.toMap(), where: '${User.colId}=?', whereArgs: [user.id]);
  }

  Future<int> query(String name, String password) async {
    Database db = await database;
    var result = await db.rawQuery(
        'SELECT * FROM USER WHERE name=? AND password=?',
        ['$name', '$password']);
    print(result);
    var dbItem = result.first;
    var resourceId = dbItem['id'];

    return resourceId;
  }

  queryUserByName(String name) async {
    Database db = await database;
    var result = await db.rawQuery(
        'SELECT * FROM USER WHERE name=?',
        ['$name']);
    print(result);
    var dbItem = result.first;
    var resourceId = dbItem['id'];

    return resourceId;
  }
  Future<int> getCount() async {
    Database db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT (*) from USER'));
    return count;
  }
}
