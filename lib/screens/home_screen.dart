import 'package:flutter/material.dart';
import '../widgets/empty_favorites.dart';
import '../widgets/favorites_list.dart';
import '../widgets/add_series_dialog.dart';

class HomeScreen extends StatefulWidget {
  // This to not make Flutter rebuild this widget when it doesn't need to.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> favoriteSeries = [];

  void _addSeries(String seriesName) {
    setState(() {
      favoriteSeries.add(seriesName);
    });
  }

  void _showAddDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return AddSeriesDialog(onAddSeries: _addSeries);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(
            opacity: anim1.value,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Series'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: favoriteSeries.isEmpty
          ? EmptyFavorites()
          : FavoriteList(
              series: favoriteSeries,
              onRemoveSeries: (series) {
                setState(() {
                  favoriteSeries.remove(series);
                });
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: const Color.fromARGB(255, 142, 217, 211),
        child: const Icon(Icons.add),
      ),
    );
  }
}
