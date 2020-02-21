import 'dart:io';

import 'package:flutter_state_management/src/models/word.dart';
import 'package:flutter_state_management/src/utils/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    String columnId = Constant.columnId;
    String columnWord = Constant.columnWord;
    String columnDescription = Constant.columnDescription;
    String columnFrequency = Constant.columnFrequency;

    await db.execute('''
              CREATE TABLE ${Constant.tableName} (
                $columnId INTEGER PRIMARY KEY,
                $columnWord TEXT NOT NULL,
                $columnDescription TEXT NOT NULL,
                $columnFrequency INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:
  Future<int> insertWord(Word word) async {
    print("inserting word into db");
    Database db = await database;
    int id = await db.insert(Constant.tableName, word.toMap());
    return id;
  }

  Future<Word> queryWord(int id) async {
    print("quering words based on id from DB");
    Database db = await database;
    List<Map> maps = await db.query(Constant.tableName,
        columns: [Constant.columnId, Constant.columnWord, Constant.columnDescription, Constant.columnFrequency],
        where: '${Constant.columnId} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Word>> getAllWords() async {
    print("Getting all words from our Database");
    Database db = await database;
    var allWords = await db.query(Constant.tableName);
    return List.generate(allWords.length, (i) {
      return Word(
          id: allWords[i][Constant.columnId],
          word: allWords[i][Constant.columnWord],
          description: allWords[i][Constant.columnDescription],
          frequency: allWords[i][Constant.columnFrequency]);
    });
  }

  Future<void> updateWord(Word word) async {
    print("Updating a word in our Database");
    // Get a reference to the database.
    Database db = await database;
    // Update the given word.
    // The Where clause ensures that // Ensure that the Dog has a matching id.
    await db.update(Constant.tableName, word.toMap(),
        where: "${Constant.columnId} = ?", whereArgs: [word.id]);
  }

  Future<void> deleteWord(Word word) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Word from the Database.
    await db.delete(
      Constant.tableName,
      // Use a `where` clause to delete a specific word.
      where: "${Constant.columnId} = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [word.id],
    );
  }
}
