import 'package:flutter/material.dart';
import 'package:flutter_state_management/bottom_nav.dart';
import 'package:provider/provider.dart';

import '../data_repository.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = "SettingsScreen";

  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> data = {"name": "", "email": "", "age": 0};

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
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // centers our column vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // centers our column horizontally
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (input) => data['name'] = input,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (input) => data['email'] = input,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  onSaved: (input) => data['age'] = int.parse(input),
                  keyboardType: TextInputType.number,
                ),
                FlatButton(
                  onPressed: () {
                    formKey.currentState.save();
                    Provider.of<DataRepository>(context).updateAccount(data);
                    formKey.currentState.reset();
                  },
                  child: Text('Submit'),
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
