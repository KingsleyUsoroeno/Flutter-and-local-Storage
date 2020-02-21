import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/models/word.dart';
import 'package:provider/provider.dart';

import '../data_repository.dart';

class WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataRepository _dataRepository = Provider.of<DataRepository>(context);
    return FutureBuilder(
      future: _dataRepository.getAllWordsFromDb(),
      builder: (context, AsyncSnapshot<List<Word>> asyncSnapshot) {
        return asyncSnapshot.data != null && asyncSnapshot.data.length == 0
            ? Center(
                child: Text(
                  'You Have No Added Notes',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                itemCount:
                    asyncSnapshot.data != null ? asyncSnapshot.data.length : 0,
                itemBuilder: (context, int position) {
                  Word word = asyncSnapshot.data[position];
                  return ListTile(
                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                      title: Text(word.word,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        word.description,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Center(
                          child: Text(
                            word.frequency.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete, size: 24.0),
                        onTap: () {
                          print("deleting word");
                          showAlertDialog(context, _dataRepository, word);
                        },
                      ));
                });
      },
    );
  }

  showAlertDialog(BuildContext context,DataRepository repository, Word word) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Delete Note'),
              content: Text('Are you sure, these action cannot be reserved'),
              actions: <Widget>[
                  FlatButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                  ),

                  FlatButton(
                      child: Text('Delete'),
                      onPressed: () {
                          repository.deleteWordFromDatabase(word);
                          Navigator.of(context).pop();
                      },
                  )
              ],
          );
        });
  }
}
