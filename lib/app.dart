import 'package:flutter/material.dart';
import 'package:my_app/screens/note_detail.dart';
import 'package:my_app/screens/note_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'Note App',
      home : HomeScreen(),
      // home : NoteDetails(),
    );
  }
}