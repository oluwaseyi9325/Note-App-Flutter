import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/note_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoteViewScreen(),
    );
  }
}

