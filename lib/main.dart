import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Favorite Series',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // Dialog background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
              color:
                  const Color.fromARGB(255, 158, 158, 158)), // Label text color
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    const Color.fromARGB(255, 194, 194, 194)), // Underline color
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.teal), // Focused underline color
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.teal,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF009688),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    )
  );
}

/*
  1. Why "const HomeScreen()"?
  2. Why two dots instead of normal "./"?
  3. What does this line "const HomeScreen({super.key});" do?
  4. https://www.linkedin.com/messaging/thread/2-Yzg3NWVmNWYtOTcxOC00MmI0LWE4YTEtMjczY2ExMThlYWFhXzEwMA==/
*/
