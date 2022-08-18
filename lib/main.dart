import 'package:english_words/english_words.dart';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GamerName Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GamerName Generator'),
        ),
        body: const Center(
          child: RandomWords(),
        ),
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
          ));
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
