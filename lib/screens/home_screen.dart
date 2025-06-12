import 'package:flutter/material.dart';
import '../screens/empty_home.dart';
import '../screens/series_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _debounce;
  final List<Map<String, dynamic>> _favoriteSeries = [];

  final TextEditingController _textController = TextEditingController();
  List<dynamic> _searchResults = [];
  Map<String, String>? _selectedSeries;
  final String apiKey = 'ce339cac75f733aea04636f6a31cc681';
  Map<String, dynamic>? showDetails;

  Future<void> searchSeries(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    final url =
        'https://api.themoviedb.org/3/search/tv?api_key=$apiKey&query=${Uri.encodeComponent(query)}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        _searchResults = json['results'];
      });
    } else {
      setState(() => _searchResults = []);
    }
  }

  Future<Map<String, dynamic>?> fetchShowDetails(int id) async {
    final detailsResponse = await http.get(
      Uri.parse('https://api.themoviedb.org/3/tv/$id?api_key=$apiKey'),
    );
    if (detailsResponse.statusCode == 200) {
      Map<String, dynamic> show = json.decode(detailsResponse.body);
      Map<int, int>? seasonsInfo = {};

      for (int i = 1; i < show["seasons"].length; i++) {
        seasonsInfo[i] = show["seasons"][i]["episode_count"];
      }

      if (show["seasons"][0]["season_number"] == 0) {
        seasonsInfo.remove(0);
      }

      setState(() {
        showDetails = {
          "number_of_seasons": show["number_of_seasons"],
          "seasons": seasonsInfo,
        };
      });
    } else {
      return {};
    }
  }

  bool _isVisible = false;
  void _toggleSearchVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void addSeries(Map<String, dynamic> show) {
    setState(() {
      _favoriteSeries.add(show);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorite Series',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: _toggleSearchVisibility,
          )
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: _isVisible,
            child: Column(children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: TextField(
                  controller: _textController,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 200), () {
                      searchSeries(value);
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (_searchResults.isNotEmpty) ...[
                Text('Results:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        _searchResults.length > 15 ? 15 : _searchResults.length,
                    itemBuilder: (context, index) {
                      final show = _searchResults[index];
                      final title = show['name'] ?? 'No Title';
                      final posterPath = show['poster_path'];
                      final showId = show["id"];
                      final posterUrl = posterPath != null
                          ? 'https://image.tmdb.org/t/p/w154$posterPath'
                          : null;

                      return ListTile(
                        leading: posterUrl != null
                            ? Image.network(
                                posterUrl,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.broken_image),
                              )
                            : Icon(Icons.image_not_supported),
                        title: Text(title),
                        onTap: () async {
                          await fetchShowDetails(showId);
                          addSeries({
                            "title": title,
                            "poster": posterUrl ?? "",
                            "number_of_seasons":
                                showDetails?["number_of_seasons"] ?? 5,
                            "seasons": showDetails?["seasons"],
                          });
                          print(_favoriteSeries);
                          _toggleSearchVisibility();
                        },
                      );
                    },
                  ),
                ),
              ]
            ]),
          ),
          _favoriteSeries.isEmpty
              ? EmptyHome()
              : Flexible(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _favoriteSeries.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 4 : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (ctx, index) {
                      final item = _favoriteSeries[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeriesScreen(seriesName: item["title"], numberOfSeasons: item["number_of_seasons"], seasonsInfo: item["seasons"],), 
                            ),
                          );
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
                                value: 'delete',
                                child: Center(
                                  child: SizedBox(
                                    child: Text(
                                      'Delete'
                                    )
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'review',
                                child: Center(
                                  child: SizedBox(
                                    child: Text(
                                      'Write a Review'
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ).then((value) {
                            if (value == 'delete') {
                              setState(() {
                                _favoriteSeries.removeWhere((series) => series['title'] == item['title']);
                              });
                            }
                          });
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (item['poster']!.isNotEmpty)
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.network(
                                      item['poster']!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${item['title'] ?? ''}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}

