import 'package:flutter/material.dart';
import 'package:anuwadak/screens/home_screen.dart';

void main() {
  runApp(const AnuwadakApp());
}

class AnuwadakApp extends StatelessWidget {
  const AnuwadakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anuwadak',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}