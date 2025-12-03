import 'package:messaging_app/data/datasources/local/message_local_datasource.dart';
import 'package:messaging_app/data/models/message_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/constants/app_constants.dart';

class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE messages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        timestamp INTEGER NOT NULL,
        isFromUser INTEGER NOT NULL,
        type INTEGER NOT NULL
      )
    ''');
  }

  @override
  Future<void> deleteAllMessages() async {
    final db = await database;
    await db.delete('messages');
  }

  @override
  Future<List<MessageModel>> getAllMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      orderBy: 'timestamp ASC',
    );
    return maps.map((map) => MessageModel.fromMap(map)).toList();
  }

  @override
  Future<int> insertMessage(MessageModel message) async {
    final db = await database;
    return await db.insert('messages', message.toMap());
  }
}
