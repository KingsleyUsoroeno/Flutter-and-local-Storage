import 'package:flutter/cupertino.dart';

class DataRepository extends ChangeNotifier{

    Map data = {
        'name': 'Frank Abignale',
        'email': 'someEmail@alligatorio',
        'age': 47
    };

    int _currentIndex = 0;

    int get currentIndex => _currentIndex;

    void updateAccount(input){
        data = input;
        notifyListeners();
    }

    void setCurrentIndex(int index){
        _currentIndex = index;
        notifyListeners();
    }
}