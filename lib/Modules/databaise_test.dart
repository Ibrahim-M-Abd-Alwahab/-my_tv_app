import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'users_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE Users(id INTEGER PRIMARY KEY, name TEXT, link TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertUser(User user) async {
    final db = await database;

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> users() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        link: maps[i]['link'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    final db = await database;

    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;

    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  var fido = const User(
    id: 0,
    name: 'Fido',
    link: 35,
  );

  await insertUser(fido);

  print(await users());

  fido = User(
    id: fido.id,
    name: fido.name,
    link: fido.link + 7,
  );
  await updateUser(fido);

  print(await users());

  await deleteUser(fido.id);

  print(await users());
}

class User {
  final int id;
  final String name;
  final int link;

  const User({
    required this.id,
    required this.name,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': link,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, age: $link}';
  }
}
