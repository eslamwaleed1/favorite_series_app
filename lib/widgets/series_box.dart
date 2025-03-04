import "package:flutter/material.dart";

class SeriesBox extends StatelessWidget {
  final String name;
  final Color color = Colors.red;

  const SeriesBox({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: "Roboto",
        ),
      ),
    );
  }
}
