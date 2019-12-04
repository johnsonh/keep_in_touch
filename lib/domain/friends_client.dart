import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../services/sql_init_scripts.dart';
import 'friend_model.dart';

class FriendsClient {
  Database _database;

  Future<Database> get database async {
    // why doesnt this work?
    if (_database != null) {
      return _database;
    }

    // if _database is null we instantiate it
    _database = await FriendsClient.initDB('friends3.db');
    return _database;
  }

  static Future<Database> initDB(String dbPathName) async {
    final String path = join(await getDatabasesPath(), dbPathName);

    final Database database = await openDatabase(
      path,
      version: SQLInitScripts.migrationScripts.length + 1,
      onCreate: (Database db, int version) async {
        for (String script in SQLInitScripts.initScript) {
           await db.execute(script);
        }
      },
      // onUpgrade: (Database db, int oldVersion, int newVersion) async {
      //   for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
      //     await db.execute(SQLInitScripts.migrationScripts[i]);
      //   }
      // }
    );
    return database;
  }

  Future<void> insertFriend(FriendModel friend) async {
    final Database db = await database;
    await db.insert(
      'friends',
      friend.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FriendModel>> getFriends() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('friends');
    return List<FriendModel>.generate(maps.length, (int i) {
      return FriendModel(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['email'],
        maps[i]['phoneNumber'],
      );
    });
  }
}
