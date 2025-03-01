import 'package:flutter/material.dart';
import 'adding_box.dart';
//import 'series_box.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //AddingBox addingSeries = AddingBox();

  bool _isAddingBoxVisible = false;
  final List<String> _favoriteSeries = [];

  // Code to handle text input. [Beginning]
  void _toggleBoxVisibility() {
    setState(() {
      _isAddingBoxVisible = !_isAddingBoxVisible;
    });
  }

  void _addSeries(String seriesName) {
    if (seriesName.trim().isNotEmpty) {
      setState(() {
        _favoriteSeries.add(seriesName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Series'),
        backgroundColor: Colors.deepPurpleAccent[200],
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: _toggleBoxVisibility,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: _favoriteSeries.isEmpty
                  ? const Center(
                      child: Text(
                        'No favorites yet?',
                        style: TextStyle(fontSize: 32, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _favoriteSeries.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(_favoriteSeries[index]),
                      ),
                    ),
            ),
            AddingBox(
              isVisible: _isAddingBoxVisible,
              onCancel: () => setState(() => _isAddingBoxVisible = false),
              onSave: _addSeries,
            ),
          ],
        ),
      ),
    );
  }
}
