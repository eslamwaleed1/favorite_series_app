import "package:flutter/material.dart";

class EpisodeTile extends StatefulWidget {
  final int episodeNumber;

  const EpisodeTile({super.key, required this.episodeNumber});

  @override
  State<EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends State<EpisodeTile> {
  bool isBlue = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBlue = !isBlue;
        });
      },
      child: Container(
        color: isBlue ? Colors.blue : Colors.white,
        width: 40,
        height: 40,
        child: Center(child: Text(widget.episodeNumber.toString())),
      ),
    );
  }
}
