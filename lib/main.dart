// ignore_for_file: prefer_const_constructors
import 'package:english_words/english_words.dart';
import 'dart:math';
import 'favorites.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      title: "Gamertags App",
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GamerName Generator',
      home: Scaffold(
        //drawerEnableOpenDragGesture: false,
        drawer: Drawer(
            width: 300,
            child: Column(
              children: [
                GradientBar("Navigation", 50),
                Container(height: 75),
                TextButton(
                    onPressed: null,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text("Suggested Names",
                            style: TextStyle(fontSize: 20)))),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Favorites())));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child:
                            Text("Favorites", style: TextStyle(fontSize: 20))))
              ],
            )),

        floatingActionButton: null,
        body: Column(children: [
          GradientBar("Gamertag", 50.0),
          Expanded(child: RandomWords())
        ]),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _favorites = <String>[];

  final animation = null;

  addFavorite(String suggestion) {
    _favorites.add(suggestion);
    print(_favorites);
  }

  removeFavorite(String suggestion) {
    _favorites.remove(suggestion);
    print(_favorites);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            for (var i = 0; i < 10; i++) {
              _suggestions.add(makePair());
            }
          }
          return ListTile(
              title: Text(
                _suggestions[index],
                style: _biggerFont,
              ),
              trailing: HeartButton(
                  wordPair: _suggestions[index],
                  add: addFavorite,
                  remove: removeFavorite));
        });
  }
}

String makePair() {
  var pair = WordPair.random().asPascalCase;

  var rng = Random();
  pair += rng.nextInt(9).toString();
  pair += rng.nextInt(9).toString();
  pair += rng.nextInt(9).toString();
  return pair;
}

class HeartButton extends StatefulWidget {
  final wordPair;
  final add;
  final remove;

  HeartButton({this.wordPair, this.add, this.remove});

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  var _color = Color.fromARGB(255, 125, 125, 125);
  final _size = 50.0;
  final _targetsize = 50.0;
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.favorite),
        color: _color,
        iconSize: _size,
        onPressed: (() {
          if (_pressed == false) {
            widget.add(widget.wordPair);
            setState(() {
              _pressed = true;
              _color = Colors.red;
            });
            return;
          }

          if (_pressed == true) {
            widget.remove(widget.wordPair);
            setState(() {
              _pressed = false;
              _color = Color.fromARGB(255, 125, 125, 125);
            });
            return;
          }
        }));
  }
}

//
/*

          */
class GradientBar extends StatelessWidget {
  final String title;
  final double height;

  GradientBar(this.title, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF00ff87), Color(0xFF60efff)],
                begin: FractionalOffset(0.0, 1.0),
                end: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Center(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF13293D),
                    fontWeight: FontWeight.bold))));
  }
}
