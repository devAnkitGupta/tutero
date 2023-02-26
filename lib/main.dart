import 'package:flutter/material.dart';
import 'galaxy/my_galaxy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Game(),
    );
  }
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => onStart(context),
        child: const Text('Start'),
      ),
    );
  }

  void onStart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyGalaxy()),
      ),
    );
  }
}
