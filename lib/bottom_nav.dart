import 'package:flutter/material.dart';
import 'package:flutter_state_management/data_repository.dart';
import 'package:flutter_state_management/src/screens/account.dart';
import 'package:flutter_state_management/src/screens/settings.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatelessWidget {
  final List<Widget> _children = [AccountScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    final DataRepository _dataRepository = Provider.of<DataRepository>(context);
    return Scaffold(
      body: _children[_dataRepository.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme
                  .of(context)
                  .primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: ((int index) => _dataRepository.setCurrentIndex(index)),
          currentIndex: _dataRepository.currentIndex,
          items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                      icon: Icon(Icons.settings), title: Text('Settings')),
          ],
      ),
    );
  }
}
