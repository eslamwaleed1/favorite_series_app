import 'package:flutter/material.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
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
