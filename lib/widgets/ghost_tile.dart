import 'package:flutter/material.dart';

class GhostTile extends StatelessWidget {
  const GhostTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Icon(Icons.emoji_emotions, color: Colors.red, size: 20),
      ),
    );
  }
}
