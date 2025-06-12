import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/episode_tile.dart';
import '../bricks/Widgets Example/gradient_blue_to_dark_blue.dart';

class SeriesScreen extends StatefulWidget {
  final String seriesName;
  final int numberOfSeasons;
  final Map<int, int> seasonsInfo;

  const SeriesScreen(
      {
        super.key,
        required this.seriesName,
        required this.numberOfSeasons,
        required this.seasonsInfo,
      }
  );

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {


  //int _numOfSeasons = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadSeasons();
  // }

  // Future<void> _loadSeasons() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _numOfSeasons = prefs.getInt('${widget.seriesName}_seasons') ?? 0;
  //   });
  // }

  // Future<void> _saveSeasons() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('${widget.seriesName}_seasons', _numOfSeasons);
  // }

  // void _addSeason() {
  //   setState(() {
  //     _numOfSeasons++;
  //     _saveSeasons();
  //   });
  // }

  // void _removeSeason() {
  //   setState(() {
  //     _numOfSeasons--;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.seriesName),
        backgroundColor: Colors.teal,
      ),
      body: DefaultTextStyle(
        style: TextStyle(fontSize: 24, color: Colors.black),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                for (int j = 1; j <= widget.numberOfSeasons; j++)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text("Season $j"),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Wrap(
                        //   spacing: 15,
                        //   runSpacing: 15,
                        //   children: [
                        //     for (int i = 1; i <= widget.seasonsInfo[j]!; i++)
                        //       EpisodeTile(
                        //         episodeNumber: i,
                        //         series: widget.seriesName,
                        //         season: j,
                        //       ),
                        //   ],
                        // ),

                        //start
                        Card(
  elevation: 4, // Adds shadow
  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Spacing around the card
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12), // Rounded corners
  ),
  child: Padding(
    padding: const EdgeInsets.all(16), // Inner padding for content
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text and tiles to the start
      children: [
        Text(
          "Season $j",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // Make season title stand out
          ),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            for (int i = 1; i <= widget.seasonsInfo[j]!; i++)
              EpisodeTile(
                episodeNumber: i,
                series: widget.seriesName,
                season: j,
              ),
          ],
        ),
      ],
    ),
  ),
),
                        //end
                        SizedBox(
                          height: 50,
                        ),
                      ]),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addSeason,
      //   backgroundColor: const Color.fromARGB(255, 207, 206, 206),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
