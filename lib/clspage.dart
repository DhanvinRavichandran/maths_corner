import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'user.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY,
            username TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Register user
  static Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  // Retrieve user by username
  static Future<Map<String, dynamic>?> getUserByUsername(String username) async {
    final db = await database;
    final users = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }
}
