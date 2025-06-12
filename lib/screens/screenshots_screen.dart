import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenshotsScreen extends StatefulWidget {
  final int seasonNumber;
  final int episodeNumber;

  const ScreenshotsScreen({
    super.key,
    required this.seasonNumber,
    required this.episodeNumber,
  });

  @override
  State<ScreenshotsScreen> createState() => _ScreenshotsScreenState();
}

class _ScreenshotsScreenState extends State<ScreenshotsScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<Map<String, dynamic>> _images = [];
  bool _isPicking = false;
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _addImage() async {
    if (_isPicking) return;
    _isPicking = true;

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _images.insert(0, {
            'file': File(pickedFile.path),
            'description': '',
          });
          _controllers[_images.length - 1] = TextEditingController();
        });
      }
    } catch (e) {
      print('Image picking error: $e');
    } finally {
      _isPicking = false;
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      _controllers.remove(index)?.dispose();

      final newControllers = <int, TextEditingController>{};
      for (var i = 0; i < _images.length; i++) {
        newControllers[i] = _controllers[i] ?? TextEditingController(text: _images[i]['description']);
      }
      _controllers.clear();
      _controllers.addAll(newControllers);
    });
  }

  void _updateDescription(int index, String newText) {
    setState(() {
      _images[index]['description'] = newText;
      _controllers[index]?.text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Season: ${widget.seasonNumber}  Episode: ${widget.episodeNumber}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _images.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final item = _images.removeAt(oldIndex);
                  _images.insert(newIndex, item);

                  final newControllers = <int, TextEditingController>{};
                  for (var i = 0; i < _images.length; i++) {
                    newControllers[i] = _controllers[oldIndex == i ? newIndex : i] ?? TextEditingController(text: _images[i]['description']);
                  }
                  _controllers.clear();
                  _controllers.addAll(newControllers);
                });
              },
              itemBuilder: (context, index) {
                final image = _images[index];
                _controllers.putIfAbsent(index, () => TextEditingController(text: image['description']));
                return Card(
                  key: ValueKey(image['file'].path),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  elevation: 2,
                  child: Column(
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Remove Image?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _removeImage(index);
                                  },
                                  child: const Text('Remove'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(
                              image: FileImage(image['file']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            ReorderableDragStartListener(
                              index: index,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.drag_handle,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _controllers[index],
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                onChanged: (text) => _updateDescription(index, text),
                                maxLines: 2,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              proxyDecorator: (child, index, animation) => AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Material(
                    elevation: 6,
                    child: child,
                  );
                },
                child: child,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton.icon(
                onPressed: _isPicking ? null : _addImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Add Image from Gallery'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}