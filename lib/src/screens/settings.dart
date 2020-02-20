import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/db/database_helpers.dart';
import 'package:flutter_state_management/src/models/word.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = "SettingsScreen";

  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {"word": "", "description": "", "frequency": 0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Account Details'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center, // centers our column vertically
                crossAxisAlignment:
                CrossAxisAlignment.center, // centers our column horizontally
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Word Title'),
                    onSaved: (input) => formData['word'] = input,
                    validator: (String title){
                      return title.isEmpty ? "Title Cannot be Empty" : null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Word Description'),
                    onSaved: (input) => formData['description'] = input,
                    keyboardType: TextInputType.text,
                    validator: (String description){
                      return description.isEmpty || description.length < 10 ? "Description cannot be empty or description is too short" : null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Frequency'),
                    onSaved: (input) => formData['frequency'] = int.parse(input),
                    keyboardType: TextInputType.number,
                    validator: (String frequency){
                      return frequency.isEmpty ? "Frequency Cannot be Empty" : null;
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      saveWord();
                    },
                    child: Text('Submit'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  saveWord() {
    print('Saving Word!!!');
    if(formKey.currentState.validate()){
      // validating input
      formKey.currentState.save();
      String title = formData['word'];
      String description = formData['description'];
      int frequency = formData['frequency'];
      Word word = Word();
      word.word = title;
      word.description = description;
      word.frequency = frequency;
      saveWordToDB(word);
    }
  }

  saveWordToDB(Word word) async {
    print("Saving Word to Db");
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = await helper.insertWord(word);
    print("inserted row id is $rowId");
    print("word inserted successfully");
  }
}
