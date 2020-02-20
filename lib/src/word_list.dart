import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/models/word.dart';

class WordList extends StatelessWidget {
  final List<Word> words;

  WordList({this.words});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.0),
        itemCount:  words.length,
        itemBuilder: (context, int position) {
          Word word = words[position];
          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(word.word,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(
              word.description,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Center(
                child: Text(word.frequency.toString()),
              ),
            ),
          );
        });
  }
}
