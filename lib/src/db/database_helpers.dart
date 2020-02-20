import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableWords = 'words';
final String columnId = '_id';
final String columnWord = 'word';
final String columnDescription = 'description';
final String columnFrequency = 'frequency';

class Word {
    int id;
    String word;
    String description;
    int frequency;

    Word({this.id, this.word, this.description, this.frequency});

    // convenience constructor to create a Word object
    Word.fromMap(Map<String, dynamic> map) {
        id = map[columnId];
        word = map[columnWord];
        description = map[columnDescription];
        frequency = map[columnFrequency];
    }

    // convenience method to create a Map from this Word object
    Map<String, dynamic> toMap() {
        var map = <String, dynamic>{
            columnWord: word,
            columnDescription: description,
            columnFrequency: frequency
        };
        if (id != null) {
            map[columnId] = id;
        }
        return map;
    }

    @override
    String toString() {
        return 'Word{id: $id, word: $word, description: $description, frequency: $frequency}';
    }
}

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
                version: _databaseVersion,
                onCreate: _onCreate);
    }

    // SQL string to create the database
    Future _onCreate(Database db, int version) async {
        await db.execute('''
              CREATE TABLE $tableWords (
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
        int id = await db.insert(tableWords, word.toMap());
        return id;
    }

    Future<Word> queryWord(int id) async {
        print("quering words based on id from DB");
        Database db = await database;
        List<Map> maps = await db.query(tableWords,
                columns: [columnId, columnWord, columnDescription, columnFrequency],
                where: '$columnId = ?',
                whereArgs: [id]);
        if (maps.isNotEmpty) {
            return Word.fromMap(maps.first);
        }
        return null;
    }

    Future<List<Word>> getAllWords() async {
        print("Getting all words from our Database");
        Database db = await database;
        var allWords = await db.query(tableWords);
        return List.generate(allWords.length, (i) {
            return Word(
                id: allWords[i][columnId],
                word: allWords[i][columnWord],
                description: allWords[i][columnDescription],
                frequency: allWords[i][columnFrequency]
            );
        });
    }

    Future<void> updateWord(Word word) async{
        print("Updating a word in our Database");
        // Get a reference to the database.
        Database db = await database;
        // Update the given word.
        // The Where clause ensures that // Ensure that the Dog has a matching id.
        await db.update(tableWords, word.toMap(), where: "id = ?", whereArgs: [word.id]);
    }

    Future<void> deleteWord(int id) async {
        // Get a reference to the database.
        final db = await database;

        // Remove the Dog from the Database.
        await db.delete(
            tableWords,
            // Use a `where` clause to delete a specific word.
            where: "id = ?",
            // Pass the Dog's id as a whereArg to prevent SQL injection.
            whereArgs: [id],
        );
    }
}