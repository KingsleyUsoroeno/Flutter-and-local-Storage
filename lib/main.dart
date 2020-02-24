import 'package:flutter/material.dart';
import 'package:flutter_state_management/bottom_nav.dart';
import 'package:flutter_state_management/data_repository.dart';
import 'package:flutter_state_management/src/screens/account.dart';
import 'package:flutter_state_management/src/screens/edit_word.dart';
import 'package:flutter_state_management/src/screens/settings.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Map data = {
    'name': 'Frank Abignale',
    'email': 'someEmail@alligatorio',
    'age': 47
  };

  DataRepository _repository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _repository = DataRepository();
    return ChangeNotifierProvider<DataRepository>(
        create: (context) => _repository,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/account_screen': (context) => AccountScreen(),
            '/settings_screen': (context) => SettingsScreen(),
            '/edit_word_screen': (context) => EditWord(),
            '/bottm_nav_screen': (context) => BottomNavigationScreen(),
          },
          home: BottomNavigationScreen(),
        ));
  }
}
