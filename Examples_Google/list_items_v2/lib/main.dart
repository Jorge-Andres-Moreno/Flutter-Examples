import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final Set<WordPair> _saved = Set<WordPair>(); // Add this line.

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
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  // Constructor 'example to onCreate' in Java android
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ], // ... to here.
      ),
      //In the body creates a  widget with_buildSuggestions() that is private method of this class
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.push(
        context, MaterialPageRoute<void>(builder: (context) => DetailPage()));
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

  // Modified the item fiel with icon
  Widget _buildRow(WordPair pair) {
    // Pregunta si la palabra esta guardada
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // trailing To show right-aligned metadata
      trailing: Icon(
        // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.blue,
      ),
      // Listener when the button item is tap
      onTap: () {
        /*In Flutter's reactive style framework, calling setState() triggers
      a call to the build() method for the State object, resulting in an update to the UI.*/
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
      // ... to here.
    );
  }
}

// add a new stateful page
class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    Iterable<ListTile> tiles = _saved.map((WordPair pair) {
      return new ListTile(
        onTap: () {
          setState(() {
            _saved.remove(pair);
          });
        },
        trailing: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      );
    });

    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: new ListView(children: divided),
    );
  }
}
