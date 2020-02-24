import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/models/word.dart';
import 'package:provider/provider.dart';

import '../../data_repository.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = "SettingsScreen";

  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {"word": "", "description": "", "frequency": 0};

  @override
  Widget build(BuildContext context) {
    final DataRepository _dataRepository = Provider.of<DataRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
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
                      onSaved: (input) => _formData['word'] = input,
                    validator: (String title){
                      return title.isEmpty ? "Title Cannot be Empty" : null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Word Description'),
                      onSaved: (input) => _formData['description'] = input,
                    keyboardType: TextInputType.text,
                    validator: (String description){
                      return description.isEmpty || description.length < 10 ? "Description cannot be empty or description is too short" : null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Frequency'),
                      onSaved: (input) => _formData['frequency'] = int.parse(input),
                    keyboardType: TextInputType.number,
                    validator: (String frequency){
                      return frequency.isEmpty ? "Frequency Cannot be Empty" : null;
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      saveWord(_dataRepository);
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
  saveWord(DataRepository repository) {
    print('Saving Word!!!');
    if(formKey.currentState.validate()){
      // validating input
      formKey.currentState.save();
      String title = _formData['word'];
      String description = _formData['description'];
      int frequency = _formData['frequency'];
      Word word = Word(
              word: title, description: description, frequency: frequency
      );
      repository.saveWordToDB(word);
    }
  }
}
