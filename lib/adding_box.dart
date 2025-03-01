import "package:flutter/material.dart";

class AddingBox extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onCancel;
  final Function(String) onSave;

  const AddingBox({
    required this.isVisible,
    required this.onCancel,
    required this.onSave,
  });

  @override
  AddingBoxState createState() => AddingBoxState();
}

class AddingBoxState extends State<AddingBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(AddingBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return SizedBox.shrink();

    return Positioned.fill(
      child: GestureDetector(
        onTap: widget.onCancel,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
              child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 300,
                        // Why added const?
                        constraints: const BoxConstraints(
                          minHeight: 200,
                        ),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: Offset(0, 5),
                              ),
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Add A Series:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                labelText: "Series Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  //onPressed: widget.onCancel,
                                  onPressed: () {
                                    _textController.clear();
                                    widget.onCancel();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[400],
                                  ),
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    widget.onSave(_textController.text);
                                    _textController.clear();
                                    widget.onCancel();
                                  },
                                  child: Text("Save"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )))),
        ),
      ),
    );
  }
}
