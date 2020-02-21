import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/db/database_helpers.dart';
import 'package:flutter_state_management/src/models/word.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataRepository extends ChangeNotifier {
  final _databaseHelper = DatabaseHelper.instance;

  Map data = {
    'name': 'Frank Abignale',
    'email': 'som   eEmail@alligatorio',
    'age': 47
  };

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateAccount(input) {
    data = input;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  saveDataToPreferences() async {
    print("saving data from sharedPreferences");
    final prefs = await SharedPreferences.getInstance();
    final prefKey = "preference_key";
    prefs.setString(prefKey, "Kingsley Usoro");
  }

  readDataFromPreferences() async {
    print("reading data from sharedPreferences");
    final prefs = await SharedPreferences.getInstance();
    final prefKey = "preference_key";
    final value = prefs.get(prefKey) ?? "";
    print("read value from prefs $value");
  }

  saveWordToDB(Word word) async {
    print("Saving Word to Db");
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = await helper.insertWord(word);
    print("inserted row id is $rowId");
    showToast("word inserted successfully", Colors.green);
    notifyListeners();
  }

  deleteWordFromDatabase(word) async {
    await _databaseHelper.deleteWord(word);
    print("deleted Word ");
    showToast("word deleted Successfully", Colors.red);
    notifyListeners();
  }

  getWordById(int rowId) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    Word word = await helper.queryWord(rowId);
    if (word == null) {
      print('read row $rowId: empty');
    } else {
      print("read word from db $word");
    }
  }

  Future<List<Word>> getAllWordsFromDb() async {
    print("Getting All words from Db");
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Word> allWords = await helper.getAllWords();
    print("allwords size is ${allWords.length}");
    if (allWords.isNotEmpty) {
      print("All words from our Db is $allWords");
      return allWords;
    } else {
      return [];
    }
  }

  showToast(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
