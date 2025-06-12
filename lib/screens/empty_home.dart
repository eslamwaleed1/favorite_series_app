import 'package:flutter/material.dart';

class EmptyHome extends StatelessWidget {
  const EmptyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: const Center(
        child: Text(
          'No favorites yet?',
          style: TextStyle(
            fontSize: 32,
            color: Color.fromARGB(255, 176, 174, 174),
          ),
        ),
      ),
    );
  }
}
