import 'package:flutter/material.dart';
import 'game.dart';
import 'homepage.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => HomePage(),
        '/settings':(context) => const SettingsScreen(),
        '/game':(context) => const Game(),
      },
    );
  }
}
