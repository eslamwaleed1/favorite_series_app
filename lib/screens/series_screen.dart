import 'package:flutter/material.dart';
import '../widgets/episode_tile.dart';

class SeriesScreen extends StatefulWidget {
  final String seriesName;

  const SeriesScreen({super.key, required this.seriesName});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  int _numOfSeasons = 0;

  @override
  void initState() {
    super.initState();
  }

  void _addSeason() {
    setState(() {
      _numOfSeasons++;
      PageStorage.of(context).writeState(context, _numOfSeasons);
    });
  }

  void _removeSeason() {
    setState(() {
      _numOfSeasons--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.seriesName)),
      body: DefaultTextStyle(
        style: TextStyle(fontSize: 24, color: Colors.black),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                for (int j = 1; j <= _numOfSeasons; j++)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Season $j"),
                        SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: [
                            for (int i = 1; i <= 24; i++)
                              EpisodeTile(episodeNumber: i),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ]),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSeason,
        backgroundColor: const Color.fromARGB(255, 207, 206, 206),
        child: Icon(Icons.add),
      ),
    );
  }
}
