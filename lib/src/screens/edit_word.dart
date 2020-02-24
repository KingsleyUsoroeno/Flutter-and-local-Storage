import 'package:flutter/material.dart';
import 'package:flutter_state_management/data_repository.dart';
import 'package:flutter_state_management/src/models/word.dart';

class EditWord extends StatelessWidget {
  final Word word;
  final Map<String, dynamic> _formData = {
    "word": "",
    "description": "",
    "frequency": 0
  };
  static final _formStateKey = GlobalKey<FormState>();

  EditWord({this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Word'),
      ),
      body: Form(
        key: _formStateKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: word.word.isNotEmpty ? word.word : "",
                  decoration: InputDecoration(labelText: 'Word title'),
                  onSaved: (input) => _formData['word'] = input,
                  validator: (String title) {
                    return title.isEmpty ? "Title cannot be empty" : null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: word.description,
                  decoration: InputDecoration(labelText: 'Description'),
                  onSaved: (input) => _formData['description'] = input,
                  validator: (String description) {
                    return description.isEmpty
                        ? "description cannot be empty"
                        : null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: word.frequency.toString(),
                  decoration: InputDecoration(labelText: 'Frequency'),
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _formData['frequency'] = int.parse(input),
                  validator: (String frequency) {
                    return frequency.isEmpty
                        ? "frequency cannot be empty"
                        : null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Edit Word',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  onPressed: () {
                    editWord(context, word.id);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  editWord(BuildContext context, int wordId) {
    final _repository = DataRepository();
    print("Editing word");
    if (_formStateKey.currentState.validate()) {
      print("Validating input");
      _formStateKey.currentState.save();
      Word word = Word(
          word: _formData['word'],
          description: _formData['description'],
          frequency: _formData['frequency']);
      print("word id is $wordId");
      _repository.updateWord(wordId, word);
      Navigator.pushNamed(context, "/bottm_nav_screen");
    }
  }
}
