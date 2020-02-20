import 'package:flutter/material.dart';
import 'package:flutter_state_management/bottom_nav.dart';
import 'package:flutter_state_management/data_repository.dart';
import 'package:flutter_state_management/screens/account.dart';
import 'package:flutter_state_management/screens/settings.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Map data = {
    'name': 'Frank Abignale',
    'email': 'someEmail@alligatorio',
    'age': 47
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataRepository>(
        create: (context) => DataRepository(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            'account_screen': (context) => AccountScreen(),
            'settings_screen': (context) => SettingsScreen(),
          },
          home: BottomNavigationScreen(),
        ));
  }
}
