import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Icon(Icons.circle, color: Colors.yellow, size: 20),
      ),
    );
  }
}
