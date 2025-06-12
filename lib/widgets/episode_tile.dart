import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../screens/screenshots_screen.dart";

class EpisodeTile extends StatefulWidget {
  final int episodeNumber;
  final String series;
  final int season;

  const EpisodeTile(
      {super.key,
      required this.episodeNumber,
      required this.series,
      required this.season});

  @override
  State<EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends State<EpisodeTile> {
  // bool _isBlue = false;
  Color tileColor = Colors.white;
  Widget? screenshotsScreen;

  @override
  // void initState() {
  //   super.initState();
  //   _loadStatus();
  // }

  // Future<void> _loadStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isBlue = prefs.getBool(
  //             '${widget.episodeNumber}_episode, ${widget.series}_series, ${widget.season}_season') ??
  //         false;
  //   });
  // }

  // Future<void> _saveStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(
  //       '${widget.episodeNumber}_episode, ${widget.series}_series, ${widget.season}_season',
  //       _isBlue);
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tileColor == Colors.white) {
          setState(() {
            //_isBlue = true;
            //_saveStatus();
            screenshotsScreen = ScreenshotsScreen(
              seasonNumber: widget.season,
              episodeNumber: widget.episodeNumber,
            );

            tileColor = Colors.blue;
          });
        } else if (tileColor == Colors.blue){
          if(screenshotsScreen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => screenshotsScreen!
              ),
            );
          }
        }
      },
      onLongPressStart: (details) {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            details.globalPosition.dy,
          ),
          items: [
            PopupMenuItem(
              value: 'unmark',
              child: Center(
                child: SizedBox(child: Text('Unmark')),
              ),
            ),
            PopupMenuItem(
              value: 'terrible',
              child: Center(
                child: SizedBox(child: Text('Mark as Terrible')),
              ),
            ),
            PopupMenuItem(
              value: 'review',
              child: Center(
                child: SizedBox(child: Text('Write a Review')),
              ),
            ),
          ],
        ).then((value) {
          if (value == 'unmark') {
            setState(() {
              tileColor = Colors.white;
            });
          }
          if (value == 'terrible') {
            setState(() {
              tileColor = Colors.yellow;
            });
          }
        });
      },
      child: Container(
        // color: tileColor,
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: tileColor,
        ),
        child: Center(child: 
          Text(
            widget.episodeNumber.toString(),
            style: TextStyle(fontSize: 18),
          )
        ),
      ),
    );
  }
}
