import 'package:flutter/material.dart';
import '../screens/series_screen.dart';

class FavoriteList extends StatelessWidget {
  final List<String> series;
  final Function(String) onRemoveSeries;

  const FavoriteList(
      {super.key, required this.series, required this.onRemoveSeries});

  void _navigateToSeries(BuildContext context, String seriesName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SeriesScreen(seriesName: seriesName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: series.length,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              series[index],
              style: TextStyle(
                fontFamily: 'Verdana',
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemoveSeries(series[index]),
            ),
            onTap: () =>
                _navigateToSeries(context, series[index]), // Navigate on tap
          ),
        );
      },
    );
  }
}
