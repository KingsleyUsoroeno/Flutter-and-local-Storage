import 'package:flutter_state_management/src/utils/constants.dart';

class Word {
  int id;
  String word;
  String description;
  int frequency;

  Word({this.id, this.word, this.description, this.frequency});

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    id = map[Constant.columnId];
    word = map[Constant.columnWord];
    description = map[Constant.columnDescription];
    frequency = map[Constant.columnFrequency];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Constant.columnWord: word,
      Constant.columnDescription: description,
      Constant.columnFrequency: frequency
    };
    if (id != null) {
      map[Constant.columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Word{id: $id, word: $word, description: $description, frequency: $frequency}';
  }
}
