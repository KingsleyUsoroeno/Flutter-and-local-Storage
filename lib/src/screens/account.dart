import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/word_list.dart';

class AccountScreen extends StatelessWidget {
  static const String id = 'account_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Notes'),
      ),
      body: WordList(),
    );
  }
}
