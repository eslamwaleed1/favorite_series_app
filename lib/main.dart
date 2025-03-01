import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  MyApp someApp = MyApp();
  // Same as: runApp(MyApp());    What a weird language that takes contstructors directly as a ready-made objects!
  runApp(someApp);
  Widget someWidget = MyApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
