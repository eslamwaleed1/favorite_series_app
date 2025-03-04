import 'package:flutter/material.dart';

class AddSeriesDialog extends StatefulWidget {
  final Function(String) onAddSeries;

  const AddSeriesDialog({super.key, required this.onAddSeries});

  @override
  State<AddSeriesDialog> createState() => _AddSeriesDialogState();
}

class _AddSeriesDialogState extends State<AddSeriesDialog> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    if (_controller.text.isNotEmpty) {
      widget.onAddSeries(_controller.text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeInOut,
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text('Add Series'),
            content: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Series Name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
