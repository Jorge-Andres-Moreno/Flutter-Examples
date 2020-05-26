// Adds new library check the file pubspec.yaml
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

// main method that run the app
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Start name generator',
      home: RandomWords(),
    );
  }
}

// The class that is the body of the application
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

// Subclass that have a list and is example of stateful widget in flutter
class RandomWordsState extends State<RandomWords> {
  //variables privadas
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // Constructor 'example to onCreate' in Java android
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      //In the body creates a  widget with_buildSuggestions() that is private method of this class
      body: _buildSuggestions(),
    );
  }

  // This widget method that is a ListView of items
  Widget _buildSuggestions() {
    // the method returns the ListView
    return ListView.builder(
        // Padding that have the list
        padding: const EdgeInsets.all(16.0),
        // NOTE: the method created one by one item in the list with this method
        itemBuilder: /*This is an callback when the item creates*/ (context,
            i) {
          // When the index of the list is 2 draw a line  for example: fluter|Android|iOS
          if (i.isOdd) return Divider();
          // Divide th index by 2 because the list have 2 types of items lines and text and
          // if divide by 2 they access in the array and not have the exception indexOutBounds
          final index = i ~/ 2;
          // if the index/2 > size of array of words then adds 10 news words in the array
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          // then return the _builRow that refers to item box of the text
          return _buildRow(_suggestions[index]);
        });
  }

// Method that creates a item that have the list
  Widget _buildRow(WordPair pair) {
    // The widget is ListTitle is a Widget refers to item a list with simple text. And, that have Text widget
    return ListTile(
      title: Text(
        // Define the style and font size of the text ( PascalCase != camelCase)
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
