import 'package:flutter/material.dart';
import 'package:flutter_state_management/data_repository.dart';
import 'package:flutter_state_management/src/db/database_helpers.dart';
import 'package:flutter_state_management/src/models/word.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatelessWidget {
  static const String id = 'account_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Name: ${Provider.of<DataRepository>(context).data['name'].toString()}'),
            Text(
                'Email: ${Provider.of<DataRepository>(context).data['email'].toString()}'),
            Text(
                'Age: ${Provider.of<DataRepository>(context).data['age'].toString()}'),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Read'),
                    onPressed: () {
                      //readDataFromPreferences();
                      //readWordFromDb();
                      getAllWordsFromDb();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      //saveDataToPreferences();
                      saveWordToDB();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
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

  saveWordToDB() async {
    print("Saving Word to Db");
    DatabaseHelper helper = DatabaseHelper.instance;
    Word word = Word();
    word.word = "Hello World";
    word.description =
        "These is my Second time saving data to a database in flutter";
    word.frequency = 50;
    int rowId = await helper.insertWord(word);
    print("inserted row id is $rowId");
  }

  readWordFromDb() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = 1;
    Word word = await helper.queryWord(rowId);
    if (word == null) {
      print('read row $rowId: empty');
    } else {
      print("read word from db $word");
    }
  }

  getAllWordsFromDb() async {
    print("Getting All words from Db");
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Word> allWords = await helper.getAllWords();
    if(allWords.isNotEmpty){
      print("All words from our Db is $allWords");
    }
  }
}
